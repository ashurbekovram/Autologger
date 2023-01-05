//
//  NetworkManager.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

import Combine
import Foundation
import NetworkManagerInterface

// 415 Unsupported Media Type - Неподдерживаемый тип данных в запросе
// 400 Bad Request - Невозможно войти с предоставленными учетными данными

public final class NetworkManagerImpl: NetworkManager {
    public private(set) var apiToken: CurrentValueSubject<String?, Never>

    public init() {
        let token: String? = KeyChain.readItem(account: "api-token", service: "autologger-network")
        apiToken = CurrentValueSubject<String?, Never>(token)
    }

    public func setApiToken(_ token: String) {
        KeyChain.saveItem(token, account: "api-token", service: "autologger-network")
        apiToken.send(token)
    }

    public func deleteApiToken() {
        KeyChain.delete(account: "api-token", service: "autologger-network")
        apiToken.send(nil)
    }

    public func send<T: HTTPRequest>(request: T) -> AnyPublisher<T.Response, Error> {
        guard let urlRequest = createUrlRequest(from: request) else {
            return Fail(error: URLError(.unsupportedURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { [weak self] data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }

                self?.debugLog(urlRequest: urlRequest, httpResponse: httpResponse, data: data)

                switch httpResponse.statusCode {
                case 200...299:
                    return data
                case 401:
                    self?.deleteApiToken()
                    throw URLError(.userAuthenticationRequired)
                default:
                    throw URLError(.dataNotAllowed)
                }
            }
            .decode(type: T.Response.self, decoder: JSONDecoder())
            .mapError { error in
                debugPrint(error)
                return error
            }
            .eraseToAnyPublisher()
    }

    private func createUrlRequest<T: HTTPRequest>(from request: T) -> URLRequest? {
        guard let baseURL = URL(string: request.baseURL) else {
            return nil
        }

        var url = baseURL.appending(path: request.path, directoryHint: .notDirectory)

        if !request.queryParams.isEmpty {
            let queryItems = request.queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
            url.append(queryItems: queryItems)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.timeoutInterval = request.timeout
        urlRequest.allHTTPHeaderFields = request.headers

        if let apiToken = apiToken.value {
            urlRequest.setValue("Token \(apiToken)", forHTTPHeaderField: "Authorization")
        }

        if !request.bodyParams.isEmpty {
            urlRequest.httpBody = try? JSONEncoder().encode(request.bodyParams)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }

    private func debugLog(
        urlRequest: URLRequest,
        httpResponse: HTTPURLResponse,
        data: Data
    ) {
        #if DEBUG
        print(
            "==============================",
            "URL: \(urlRequest.url?.absoluteString ?? "none")",
            "METHOD: \(urlRequest.httpMethod ?? "none")",
            "HEADERS: \(urlRequest.allHTTPHeaderFields ?? [:])",
            "STATUS CODE: \(httpResponse.statusCode)",
            "RESPONSE:",
            data.prettyPrintedJSONString ?? "Data is not allowed",
            "==============================",
            separator: "\n"
        )
        #endif
    }
}

// dataTaskPublisher возвращает ошибки нетворка в data, поэтому их обрабатывать нужно руками
// В error возвращаются клиентские ошибки (нет доступа к нету или ошибка декода)
// поэтому в идеале тут использовать не map, а tryMap и выбрасывать ошибки в throws
// и обрабатывать statusCode у ответа - response as? HTTPURLResponse)?.statusCode


fileprivate extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else {
            return nil
        }

        return prettyPrintedString
    }
}

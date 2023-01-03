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
    public init() {}

    public func send<T: HTTPRequest>(request: T) -> AnyPublisher<T.Response, Error> {
        guard let urlRequest = createUrlRequest(from: request) else {
            return Fail(error: URLError(.unsupportedURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                debugPrint(data.prettyPrintedJSONString ?? URLError.cannotDecodeRawData)
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }

                switch httpResponse.statusCode {
                case 200...299:
                    return data
                default:
                    throw URLError(.dataNotAllowed)
                }
            }
            .decode(type: T.Response.self, decoder: JSONDecoder())
            .mapError { error in
                debugPrint(error)
                return error
            }
            .receive(on: RunLoop.main)
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

        if !request.bodyParams.isEmpty {
            urlRequest.httpBody = try? JSONEncoder().encode(request.bodyParams)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
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

//
//  NetworkManager.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

import Combine
import Foundation
import NetworkManagerInterface

public final class NetworkManagerImpl: NetworkManager {
    public init() {}

    public func send<T: HTTPRequest>(request: T) -> AnyPublisher<T.Response, Error> {
        guard let urlRequest = createUrlRequest(from: request) else {
            return Fail(error: URLError(.unsupportedURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)         
            .tryMap { data, response in
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
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    private func createUrlRequest<T: HTTPRequest>(from request: T) -> URLRequest? {
        let urlString = request.baseURL + request.path

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = request.parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let urlWithParameters = urlComponents?.url else {
            return nil
        }
        var urlRequest = URLRequest(url: urlWithParameters)
        urlRequest.timeoutInterval = request.timeout
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers

        return urlRequest
    }
}

// dataTaskPublisher возвращает ошибки нетворка в data, поэтому их обрабатывать нужно руками
// В error возвращаются клиентские ошибки (нет доступа к нету или ошибка декода)
// поэтому в идеале тут использовать не map, а tryMap и выбрасывать ошибки в throws
// и обрабатывать statusCode у ответа - response as? HTTPURLResponse)?.statusCode

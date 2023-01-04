//
//  File.swift
//  
//
//  Created by Ramazan Ashurbekov on 03.08.2022.
//

import Combine

public protocol NetworkManager {
    func setApiToken(_ token: String)
    func deleteApiToken()
    func send<T: HTTPRequest>(request: T) -> AnyPublisher<T.Response, Error>
}

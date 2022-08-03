//
//  File.swift
//  
//
//  Created by Ramazan Ashurbekov on 03.08.2022.
//

import Combine

public protocol NetworkManager {
    func send<T: HTTPRequest>(request: T) -> AnyPublisher<T.Response, Error>
}

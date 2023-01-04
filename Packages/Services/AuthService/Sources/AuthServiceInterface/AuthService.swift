//
//  AuthService.swift
//  
//
//  Created by Ramazan Ashurbekov on 02.01.2023.
//

import Combine

public protocol AuthService {
    var isAuthorized: CurrentValueSubject<Bool, Never> { get }

    func login(username: String, password: String) -> AnyPublisher<Void, Error>
}

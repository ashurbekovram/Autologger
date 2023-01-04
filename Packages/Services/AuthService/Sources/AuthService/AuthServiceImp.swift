//
//  AuthServiceImp.swift
//  
//
//  Created by Ramazan Ashurbekov on 02.01.2023.
//

import AuthServiceInterface
import Combine
import NetworkManagerInterface

public final class AuthServiceImp: AuthService {
    private let networkManager: NetworkManager
    private var cancellableSet = Set<AnyCancellable>()

    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    public func login(username: String, password: String) -> AnyPublisher<Void, Error> {
        let request = AuthLoginRequest(
            username: username,
            password: password
        )

        return networkManager
            .send(request: request)
            .map { [weak self] response in
                self?.networkManager.setApiToken(response.authToken)
                return ()
            }
            .eraseToAnyPublisher()
    }
}

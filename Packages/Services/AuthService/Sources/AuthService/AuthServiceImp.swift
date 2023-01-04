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
    public private(set) var isAuthorized: CurrentValueSubject<Bool, Never>

    private let networkManager: NetworkManager
    private var cancellableSet = Set<AnyCancellable>()

    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.isAuthorized = CurrentValueSubject<Bool, Never>(networkManager.apiToken.value != nil)
        bind()
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

    private func bind() {
        networkManager.apiToken
            .dropFirst()
            .removeDuplicates()
            .map { $0 != nil }
            .assign(to: \.value, on: isAuthorized)
            .store(in: &cancellableSet)
    }
}

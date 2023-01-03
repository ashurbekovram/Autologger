//
//  AuthViewModel.swift
//  
//
//  Created by Ramazan Ashurbekov on 18.10.2022.
//

import AuthServiceInterface
import Combine

final class AuthViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""

    private let authService: AuthService

    private var cancellableSet = Set<AnyCancellable>()

    init(authService: AuthService) {
        self.authService = authService
    }

    func login() {
        authService.login(username: username, password: password)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("FAILURE \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { _ in
                print("SUCCESS")
            }
            .store(in: &cancellableSet)
    }
}

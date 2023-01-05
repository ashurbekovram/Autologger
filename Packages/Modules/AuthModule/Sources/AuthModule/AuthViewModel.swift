//
//  AuthViewModel.swift
//  
//
//  Created by Ramazan Ashurbekov on 18.10.2022.
//

import AuthServiceInterface
import Combine
import ProfileServiceInterface

final class AuthViewModel: ObservableObject {
    @Published var username: String = "pythonadmin"
    @Published var password: String = "pythonPass"

    private let authService: AuthService
    private let profileService: ProfileService

    private var cancellableSet = Set<AnyCancellable>()

    init(
        authService: AuthService,
        profileService: ProfileService
    ) {
        self.authService = authService
        self.profileService = profileService
    }

    func login() {
        authService.login(username: username, password: password)
            .sink { _ in } receiveValue: { [weak self] _ in
                self?.fetchProfile()
            }
            .store(in: &cancellableSet)
    }

    private func fetchProfile() {
        profileService.fetchProfile()
            .sink { _ in } receiveValue: { _ in }
            .store(in: &cancellableSet)
    }
}

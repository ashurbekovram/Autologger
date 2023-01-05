//
//  ProfileViewModel.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import AuthServiceInterface
import Combine
import Models
import ProfileServiceInterface
import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var profile: Profile?
    @Published private(set) var error: Error?

    let viewFactory: ProfileViewFactory

    private let profileService: ProfileService
    private let authService: AuthService
    private var cancellableSet = Set<AnyCancellable>()

    init(
        viewFactory: ProfileViewFactory,
        profileService: ProfileService,
        authService: AuthService
    ) {
        self.viewFactory = viewFactory
        self.profileService = profileService
        self.authService = authService
        setupBindings()
        print("\(type(of: self)) init")
    }

    deinit {
        print("\(type(of: self)) deinit")
    }

    private func setupBindings() {
        profileService.isProfileLoading
            .removeDuplicates()
            .assign(to: &$isLoading)

        profileService.profile
            .removeDuplicates()
            .assign(to: &$profile)
    }

    func onAppear() {
        guard profile == nil else {
            return
        }
        fetchProfile()
    }

    func fetchProfile() {
        profileService.fetchProfile()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    break
                }
            } receiveValue: { _ in }
            .store(in: &cancellableSet)
    }

    func logout() {
        authService
            .logout()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    break
                }
            } receiveValue: { _ in }
            .store(in: &cancellableSet)
    }
}

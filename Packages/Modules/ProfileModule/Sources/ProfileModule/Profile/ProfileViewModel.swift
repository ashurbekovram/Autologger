//
//  ProfileViewModel.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import Combine
import Models
import ProfileServiceInterface
import SwiftUI

struct ProfileState {
    var isLoading: Bool
    var profile: Profile?
    var error: Error?
}

final class ProfileViewModel: ObservableObject {
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var profile: Profile?
    @Published private(set) var error: Error?

    let viewFactory: ProfileViewFactory

    private let profileService: ProfileService
    private var cancellableSet = Set<AnyCancellable>()

    init(
        viewFactory: ProfileViewFactory,
        profileService: ProfileService
    ) {
        self.viewFactory = viewFactory
        self.profileService = profileService
        setupBindings()
        print("\(type(of: self)) init")
    }

    deinit {
        print("\(type(of: self)) deinit")
    }

    private func setupBindings() {
        profileService.profile
            .removeDuplicates()
            .assign(to: &$profile)
    }

    func onAppear() {
        if self.profile != nil {
            isLoading = false
        } else {
            fetchProfile()
        }
    }

    func fetchProfile() {
        isLoading = true
        profileService.fetchProfile()
            .sink { [weak self] completion in
                self?.isLoading = false
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

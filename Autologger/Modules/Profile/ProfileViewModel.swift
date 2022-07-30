//
//  ProfileViewModel.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import Combine
import Models
import ProfileService
import SwiftUI

struct ProfileState {
    var isLoading: Bool
    var profile: Profile?
    var error: Error?
}

protocol ProfileViewModelProtocol: ObservableObject {
    var editProfileView: (() -> AnyView) { get }

    var isLoading: Bool { get }
    var profile: Profile? { get }
    var error: Error? { get }

    func onAppear()
    func fetchProfile()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var profile: Profile?
    @Published private(set) var error: Error?

    private(set) var editProfileView: (() -> AnyView)

    private let profileService: ProfileService
    private var cancellableSet = Set<AnyCancellable>()

    init(
        profileService: ProfileService,
        editProfileView: @escaping (() -> AnyView)
    ) {
        self.profileService = profileService
        self.editProfileView = editProfileView
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

//
//  EditProfileViewModel.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import Combine
import Foundation
import Models
import ProfileServiceInterface

final class EditProfileViewModel: ObservableObject {
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isSuccessUpdating: Bool = false
    @Published private(set) var error: String?
    @Published var email: String
    @Published var username: String

    private var profileService: ProfileService
    private var cancellableSet = Set<AnyCancellable>()

    init(profileService: ProfileService) {
        self.profileService = profileService
        self.email = profileService.profile.value?.email ?? ""
        self.username = profileService.profile.value?.username ?? ""
        print("\(type(of: self)) init")
    }

    deinit {
        print("\(type(of: self)) deinit")
    }

    private func setupBindings() {
        profileService.profile
            .removeDuplicates()
            .sink { [weak self] profile in
                guard let profile = profile else {
                    return
                }

                self?.email = profile.email
                self?.username = profile.username
            }
            .store(in: &cancellableSet)
    }

    func updateProfile() {
        guard let id = profileService.profile.value?.id else {
            return
        }

        isLoading = true
        let profile = Profile(id: id, email: email, username: username, imageURL: nil)
        profileService.updateProfile(profile)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.error = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] _ in
                self?.isSuccessUpdating = true
            }
            .store(in: &cancellableSet)
    }
}

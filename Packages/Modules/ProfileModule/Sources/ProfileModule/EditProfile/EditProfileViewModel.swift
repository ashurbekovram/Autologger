//
//  EditProfileViewModel.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import Combine
import Foundation
import Models
import ProfileService

protocol EditProfileViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }
    var isSuccessUpdating: Bool { get }
    var error: String? { get }

    var name: String { get set }
    var secondName: String { get set }

    func updateProfile()
}

final class EditProfileViewModel: EditProfileViewModelProtocol {
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isSuccessUpdating: Bool = false
    @Published private(set) var error: String?
    @Published var name: String = ""
    @Published var secondName: String = ""

    private var profileService: ProfileService
    private var cancellableSet = Set<AnyCancellable>()

    init(profileService: ProfileService) {
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
            .sink { [weak self] profile in
                guard let profile = profile else {
                    return
                }

                self?.name = profile.name
                self?.secondName = profile.secondName
            }
            .store(in: &cancellableSet)
    }

    func updateProfile() {
        isLoading = true
        let profile = Profile(name: name, secondName: secondName, imageURL: nil)
        profileService.updateProfile(profile)
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

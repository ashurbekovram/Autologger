//
//  ProfileFlowCoordinator.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import SwiftUI

final class ProfileFlowCoordinator: Coordinator {
    func start() -> AnyView {
        profileView()
    }
}

extension ProfileFlowCoordinator {
    private func profileView() -> AnyView {
        let editProfileView = editProfileView()
        let viewModel = ProfileViewModel(
            profileService: AppAssembler.profileService,
            editProfileView: { editProfileView }
        )
        return AnyView(ProfileView(viewModel: viewModel))
    }

    func editProfileView() -> AnyView {
        let viewModel = EditProfileViewModel(profileService: AppAssembler.profileService)
        return AnyView(EditProfileView(viewModel: viewModel))
    }
}

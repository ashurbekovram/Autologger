//
//  ProfileModuleAssembler.swift
//  
//
//  Created by Ramazan Ashurbekov on 03.08.2022.
//

import ProfileService
import SwiftUI

public struct ProfileModuleInputModel {
    let profileService: ProfileService
    weak var viewFactory: ProfileViewFactory?

    public init(
        profileService: ProfileService,
        viewFactory: ProfileViewFactory?
    ) {
        self.profileService = profileService
        self.viewFactory = viewFactory
    }
}

public final class ProfileModuleAssembler {
    public static func assembleModule(with inputModel: ProfileModuleInputModel) -> AnyView {
        let viewModel = ProfileViewModel(
            viewFactory: inputModel.viewFactory,
            profileService: inputModel.profileService
        )
        return AnyView(ProfileView(viewModel: viewModel))
    }
}

//
//  ProfileAssembler.swift
//  
//
//  Created by Ramazan Ashurbekov on 03.08.2022.
//

import ProfileService
import SwiftUI

public struct ProfileInputModel {
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

public final class ProfileAssembler {
    public static func assembleModule(with inputModel: ProfileInputModel) -> AnyView {
        let viewModel = ProfileViewModel(
            viewFactory: inputModel.viewFactory,
            profileService: inputModel.profileService
        )
        return AnyView(ProfileView(viewModel: viewModel))
    }
}

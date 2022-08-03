//
//  EditProfileAssembler.swift
//  
//
//  Created by Ramazan Ashurbekov on 03.08.2022.
//

import ProfileServiceInterface
import SwiftUI

public struct EditProfileInputModel {
    let profileService: ProfileService

    public init(
        profileService: ProfileService
    ) {
        self.profileService = profileService
    }
}

public final class EditProfileAssembler {
    public static func assembleModule(with inputModel: EditProfileInputModel) -> AnyView {
        let viewModel = EditProfileViewModel(
            profileService: inputModel.profileService
        )
        return AnyView(EditProfileView(viewModel: viewModel))
    }
}

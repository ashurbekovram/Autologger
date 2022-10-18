//
//  EditProfileInputModel.swift
//  
//
//  Created by Ramazan Ashurbekov on 18.10.2022.
//

import ProfileServiceInterface

public struct EditProfileInputModel {
    let profileService: ProfileService

    public init(
        profileService: ProfileService
    ) {
        self.profileService = profileService
    }
}

//
//  AuthInputModel.swift
//  
//
//  Created by Ramazan Ashurbekov on 03.01.2023.
//

import AuthServiceInterface
import ProfileServiceInterface

public struct AuthInputModel {
    let authService: AuthService
    let profileService: ProfileService

    public init(
        authService: AuthService,
        profileService: ProfileService
    ) {
        self.authService = authService
        self.profileService = profileService
    }
}

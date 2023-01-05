//
//  ProfileInputModel.swift
//  
//
//  Created by Ramazan Ashurbekov on 03.08.2022.
//

import AuthServiceInterface
import ProfileServiceInterface

public struct ProfileInputModel {
    let viewFactory: ProfileViewFactory
    let profileService: ProfileService
    let authService: AuthService

    public init(
        viewFactory: ProfileViewFactory,
        profileService: ProfileService,
        authService: AuthService
    ) {
        self.viewFactory = viewFactory
        self.profileService = profileService
        self.authService = authService
    }
}

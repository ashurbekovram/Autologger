//
//  ProfileInputModel.swift
//  
//
//  Created by Ramazan Ashurbekov on 03.08.2022.
//

import ProfileServiceInterface
import SwiftUI

public struct ProfileInputModel {
    let viewFactory: ProfileViewFactory
    let profileService: ProfileService

    public init(
        viewFactory: ProfileViewFactory,
        profileService: ProfileService
    ) {
        self.viewFactory = viewFactory
        self.profileService = profileService
    }
}

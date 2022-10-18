//
//  ProfileInputModel.swift
//  
//
//  Created by Ramazan Ashurbekov on 03.08.2022.
//

import ProfileServiceInterface
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

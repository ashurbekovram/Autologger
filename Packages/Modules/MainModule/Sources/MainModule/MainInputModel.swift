//
//  File.swift
//  
//
//  Created by Ramazan Ashurbekov on 02.08.2022.
//

import ProfileServiceInterface
import SwiftUI
import UserAutosService

public struct MainInputModel {
    let viewFactory: MainViewFactory
    let profileService: ProfileService
    let userAutosService: UserAutosService

    public init(
        viewFactory: MainViewFactory,
        profileService: ProfileService,
        userAutosService: UserAutosService
    ) {
        self.viewFactory = viewFactory
        self.profileService = profileService
        self.userAutosService = userAutosService
    }
}

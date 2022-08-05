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
    let profileService: ProfileService
    let userAutosService: UserAutosService
    weak var viewFactory: MainViewFactory?

    public init(
        profileService: ProfileService,
        userAutosService: UserAutosService,
        viewFactory: MainViewFactory?
    ) {
        self.profileService = profileService
        self.userAutosService = userAutosService
        self.viewFactory = viewFactory
    }
}

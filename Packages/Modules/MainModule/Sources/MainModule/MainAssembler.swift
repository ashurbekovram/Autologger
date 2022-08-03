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

public final class MainAssembler {
    public static func assembleModule(with inputModel: MainInputModel) -> AnyView {
        let viewModel = MainViewModel(
            viewFactory: inputModel.viewFactory,
            profileService: inputModel.profileService,
            userAutosService: inputModel.userAutosService
        )
        return AnyView(MainView(viewModel: viewModel))
    }
}

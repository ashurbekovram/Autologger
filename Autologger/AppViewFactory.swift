//
//  AppViewFactory.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.08.2022.
//

import EditAutoModule
import MainModule
import ProfileModule
import SwiftUI

final class AppViewFactory {
    static var shared = AppViewFactory()

    private init() {}

    func createMainView() -> AnyView {
        let inputModel = MainInputModel(
            profileService: AppAssembler.profileService,
            userAutosService: AppAssembler.userAutosService,
            viewFactory: self
        )
        return AnyView(MainView(inputModel: inputModel))
    }

    func createProfileView() -> AnyView {
        let inputModel = ProfileInputModel(
            profileService: AppAssembler.profileService,
            viewFactory: self
        )
        return ProfileAssembler.assembleModule(with: inputModel)
    }
}

extension AppViewFactory: MainViewFactory {
    func createEditAutoView() -> AnyView {
        let inputModel = EditAutoInputModel(
            makesService: AppAssembler.makesService,
            userAutosService: AppAssembler.userAutosService
        )
        return AnyView(EditAutoView(inputModel: inputModel))
    }
}

extension AppViewFactory: ProfileViewFactory {
    func createEditProfileView() -> AnyView {
        let inputModel = EditProfileInputModel(profileService: AppAssembler.profileService)
        return EditProfileAssembler.assembleModule(with: inputModel)
    }
}

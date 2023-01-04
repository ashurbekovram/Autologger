//
//  AppViewFactory.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.08.2022.
//

import AuthModule
import EditAutoModule
import MainModule
import ProfileModule
import SwiftUI

final class AppViewFactory {
    static var shared = AppViewFactory()

    private init() {}

    func createTabView() -> AnyView {
        let inputModel = AppTabInputModel(
            viewFactory: self,
            authService: AppAssembler.authService
        )
        return AnyView(AppTabView(inputModel: inputModel))
    }
}

extension AppViewFactory: AppTabViewFactory {
    func createMainView() -> AnyView {
        let inputModel = MainInputModel(
            viewFactory: self,
            profileService: AppAssembler.profileService,
            userAutosService: AppAssembler.userAutosService
        )
        return AnyView(MainView(inputModel: inputModel))
    }

    func createProfileView() -> AnyView {
        let inputModel = ProfileInputModel(
            viewFactory: self,
            profileService: AppAssembler.profileService
        )
        return AnyView(ProfileView(inputModel: inputModel))
    }

    func createAuthView() -> AnyView {
        let inputModel = AuthInputModel(authService: AppAssembler.authService)
        return AnyView(AuthView(inputModel: inputModel))
    }
}

extension AppViewFactory: MainViewFactory {
    func createEditAutoView() -> AnyView {
        let inputModel = EditAutoInputModel(
            vehiclesService: AppAssembler.vehiclesService,
            userAutosService: AppAssembler.userAutosService
        )
        return AnyView(EditAutoView(inputModel: inputModel))
    }
}

extension AppViewFactory: ProfileViewFactory {
    func createEditProfileView() -> AnyView {
        let inputModel = EditProfileInputModel(
            profileService: AppAssembler.profileService
        )
        return AnyView(EditProfileView(inputModel: inputModel))
    }
}

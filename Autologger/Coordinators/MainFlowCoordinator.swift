//
//  MainFlowCoordinator.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import SwiftUI

final class MainFlowCoordinator: Coordinator {
    func start() -> AnyView {
        mainView()
    }
}

extension MainFlowCoordinator {
    private func mainView() -> AnyView {
        let editAutoView = editAutoView()
        let viewModel = MainViewModel(
            profileService: AppAssembler.profileService,
            userAutosService: AppAssembler.userAutosService,
            editAutoView: { editAutoView }
        )
        return AnyView(MainView(viewModel: viewModel))
    }

    private func editAutoView() -> AnyView {
        let viewModel = EditAutoViewModel(
            makesService: AppAssembler.makesService,
            userAutosService: AppAssembler.userAutosService
        )
        return AnyView(EditAutoView(viewModel: viewModel))
    }
}

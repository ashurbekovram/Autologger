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
        let viewModel = MainViewModel(
            profileService: AppAssembler.profileService,
            userAutosService: AppAssembler.userAutosService,
            output: self
        )
        return AnyView(MainView(viewModel: viewModel))
    }
}

extension MainFlowCoordinator: MainViewModelOutput {
    func createEditAutoView() -> AnyView {
        let viewModel = EditAutoViewModel(
            makesService: AppAssembler.makesService,
            userAutosService: AppAssembler.userAutosService
        )
        return AnyView(EditAutoView(viewModel: viewModel))
    }
}

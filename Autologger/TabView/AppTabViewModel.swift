//
//  AppTabViewModel.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 18.10.2022.
//

import Foundation
import Models
import AuthServiceInterface

final class AppTabViewModel: ObservableObject {
    let appTabFactory: AppTabViewFactory

    private let authService: AuthService

    @Published private(set) var isAuthorized: Bool

    init(
        authService: AuthService,
        appTabFactory: AppTabViewFactory
    ) {
        self.authService = authService
        self.appTabFactory = appTabFactory
        self.isAuthorized = authService.isAuthorized.value
        setupBindings()
    }

    private func setupBindings() {
        authService.isAuthorized
            .dropFirst()
            .removeDuplicates()
            .assign(to: &$isAuthorized)
    }
}

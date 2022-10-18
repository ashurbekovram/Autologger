//
//  AppTabViewModel.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 18.10.2022.
//

import Foundation
import Models
import ProfileServiceInterface

final class AppTabViewModel: ObservableObject {
    let appTabFactory: AppTabViewFactory

    private let profileService: ProfileService

    @Published private(set) var profile: Profile?

    init(
        profileService: ProfileService,
        appTabFactory: AppTabViewFactory
    ) {
        self.profileService = profileService
        self.appTabFactory = appTabFactory
        setupBindings()
    }

    private func setupBindings() {
        profileService.profile
            .removeDuplicates()
            .assign(to: &$profile)
    }
}

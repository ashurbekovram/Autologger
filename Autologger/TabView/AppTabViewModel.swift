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
    let isAuthorized: Bool

    let appTabFactory: AppTabViewFactory

    private let profileService: ProfileService

    init(
        appTabFactory: AppTabViewFactory,
        profileService: ProfileService
    ) {
        self.appTabFactory = appTabFactory
        self.profileService = profileService
        self.isAuthorized = profileService.profile.value != nil
    }
}

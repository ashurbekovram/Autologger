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

    init(appTabFactory: AppTabViewFactory) {
        self.appTabFactory = appTabFactory
    }
}

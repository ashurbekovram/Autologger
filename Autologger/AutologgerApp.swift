//
//  AutologgerApp.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 01.07.2022.
//

import SwiftUI

@main
struct AutologgerApp: App {
    var body: some Scene {
        WindowGroup {
            AppTabView(
                mainFlowCoordinator: MainFlowCoordinator(),
                profileFlowCoordinator: ProfileFlowCoordinator()
            )
        }
    }
}

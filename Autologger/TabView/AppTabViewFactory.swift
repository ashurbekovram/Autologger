//
//  AppTabViewFactory.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 18.10.2022.
//

import SwiftUI

protocol AppTabViewFactory {
    func createMainView() -> AnyView
    func createProfileView() -> AnyView
    func createAuthView() -> AnyView
}

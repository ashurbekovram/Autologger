//
//  MainViewModelOutputMock.swift
//  AutologgerTests
//
//  Created by Ramazan Ashurbekov on 31.07.2022.
//

import SwiftUI
@testable import Autologger
@testable import Models

final class MainViewModelOutputMock: MainViewModelOutput {
    var isCreateEditAutoViewCalled: Bool = false

    func createEditAutoView() -> AnyView {
        isCreateEditAutoViewCalled = true
        return AnyView(EmptyView())
    }
}

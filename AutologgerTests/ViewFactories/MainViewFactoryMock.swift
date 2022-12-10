//
//  MainViewFactoryMock.swift
//  AutologgerTests
//
//  Created by Ramazan Ashurbekov on 10.12.2022.
//

import MainModule
import SwiftUI

final class MainViewFactoryMock: MainViewFactory {
    func createEditAutoView() -> AnyView {
        AnyView(EmptyView())
    }
}

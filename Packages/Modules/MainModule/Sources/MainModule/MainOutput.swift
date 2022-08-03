//
//  MainViewFactory.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 31.07.2022.
//

import SwiftUI

public protocol MainViewFactory: AnyObject {
    func createEditAutoView() -> AnyView
}

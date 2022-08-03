//
//  ProfileViewFactory.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.08.2022.
//

import SwiftUI

public protocol ProfileViewFactory: AnyObject {
    func createEditProfileView() -> AnyView
}

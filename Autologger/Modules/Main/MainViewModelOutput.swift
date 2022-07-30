//
//  MainViewModelOutput.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 31.07.2022.
//

import SwiftUI

protocol MainViewModelOutput: AnyObject {
    func createEditAutoView() -> AnyView
}

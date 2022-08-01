//
//  Profile.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 01.07.2022.
//

import SwiftUI

public struct Profile: Codable, Equatable {
    public let name: String
    public let secondName: String
    public let imageURL: URL?

    public init(
        name: String,
        secondName: String,
        imageURL: URL?
    ) {
        self.name = name
        self.secondName = secondName
        self.imageURL = imageURL
    }
}

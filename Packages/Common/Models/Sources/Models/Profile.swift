//
//  Profile.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 01.07.2022.
//

import SwiftUI

public struct Profile: Codable, Equatable {
    public let id: Int
    public let email: String
    public let username: String
    public let imageURL: URL?

    public init(
        id: Int,
        email: String,
        username: String,
        imageURL: URL?
    ) {
        self.id = id
        self.email = email
        self.username = username
        self.imageURL = imageURL
    }
}

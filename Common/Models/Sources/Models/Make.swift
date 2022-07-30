//
//  Make.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

public struct Make: Decodable, Hashable, Identifiable {
    public let id: Int
    public let name: String

    public init(
        id: Int,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}

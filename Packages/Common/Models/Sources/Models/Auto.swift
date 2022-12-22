//
//  Auto.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 01.07.2022.
//

import SwiftUI

public struct Auto: Identifiable, Codable, Equatable {
    public var id = UUID() // Identifiable

    public let brand: String // Edd enum with AT
    public let model: String // Add dependency from enum
    public let year: Int
    public let vin: String
    public let photo: Data?
    public let number: String? // Add formatter

    public init(
        brand: String,
        model: String,
        year: Int,
        vin: String,
        photo: Data? = nil,
        number: String? = nil
    ) {
        self.brand = brand
        self.model = model
        self.year = year
        self.vin = vin
        self.photo = photo
        self.number = number
    }
}

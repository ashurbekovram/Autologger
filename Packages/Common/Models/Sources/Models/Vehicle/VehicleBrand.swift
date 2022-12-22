//
//  VehicleBrand.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

public struct VehicleBrand: Decodable, Hashable, Identifiable {
    public let id: Int
    public let name: String
    public let description: String
    public let foundingDate: String
    public let country: Country
    public let series: [VehicleSeries]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case foundingDate = "founding_date"
        case country
        case series
    }
}

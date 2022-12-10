//
//  Make.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

public struct Make: Decodable, Hashable, Identifiable {
    public let id: Int
    public let name: String
    public let description: String
    public let foundingDate: String
    public let country: Country
    public let series: [Series]

    enum CodingKeys: CodingKey {
        case id
        case name
        case description
        case foundingDate
        case country
        case series
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.foundingDate = try container.decode(String.self, forKey: .foundingDate)
        self.country = try container.decode(Country.self, forKey: .country)
        self.series = try container.decode([Series].self, forKey: .series)
    }

    public init(
        id: Int,
        name: String,
        description: String,
        foundingDate: String,
        country: Country,
        series: [Series]
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.foundingDate = foundingDate
        self.country = country
        self.series = series
    }
}


public struct Series: Decodable, Hashable {
    let id: Int
    let name: String
}

//
//  VehicleGeneration.swift
//  
//
//  Created by Ramazan Ashurbekov on 10.12.2022.
//

public struct VehicleGeneration: Decodable, Hashable, Identifiable {
    public let id: Int
    public let name: String
    public let startYear: Int
    public let endYear: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case startYear = "start_year"
        case endYear = "end_year"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.startYear = try container.decode(Int.self, forKey: .startYear)
        self.endYear = try container.decode(Int.self, forKey: .endYear)
    }
}

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
}

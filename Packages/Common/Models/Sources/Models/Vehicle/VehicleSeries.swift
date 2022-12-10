//
//  VehicleSeries.swift
//  
//
//  Created by Ramazan Ashurbekov on 10.12.2022.
//

public struct VehicleSeries: Decodable, Hashable {
    let id: Int
    let name: String
    let generations: [VehicleGeneration]
}

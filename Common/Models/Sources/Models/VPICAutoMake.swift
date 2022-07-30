//
//  VPICAutoMake.swift
//  
//
//  Created by Ramazan Ashurbekov on 09.07.2022.
//

public struct VPICAutoMake: Decodable {
    public let id: Int
    public let name: String

    enum CodingKeys: String, CodingKey {
        case id = "Make_ID"
        case name = "Make_Name"
    }
}

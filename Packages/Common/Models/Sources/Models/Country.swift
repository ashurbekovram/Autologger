//
//  Country.swift
//  
//
//  Created by Ramazan Ashurbekov on 10.12.2022.
//

public struct Country: Decodable, Hashable {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

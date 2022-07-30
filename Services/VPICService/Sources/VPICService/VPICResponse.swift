//
//  VPICResponse.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

import Models

struct VPICResponse: Decodable {
    let count: Int
    let message: String
    let results: [VPICAutoMake]

    enum CodingKeys: String, CodingKey {
        case count = "Count"
        case message = "Message"
        case results = "Results"
    }
}

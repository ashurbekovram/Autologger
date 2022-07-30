//
//  HTTPRequest.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

import Foundation

public protocol HTTPRequest {
    associatedtype Response: Decodable

    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var parameters: [String: String] { get }
    var method: HTTPMethod { get }
    var timeout: TimeInterval { get }
}

public extension HTTPRequest {
    var baseURL: String {
        "https://car-database.p.rapidapi.com"
    }

    var headers: [String: String] {
        [
            "X-RapidAPI-Key": "73a7994d00msh9360da29c32f6fdp16f551jsn19ac5e174a2d",
            "X-RapidAPI-Host": "car-database.p.rapidapi.com"
        ]
    }

    var timeout: TimeInterval {
        10.0
    }
}

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
        "https://ashurbekovram.pythonanywhere.com"
    }

    var headers: [String: String] {
        [:]
    }

    var timeout: TimeInterval {
        10.0
    }
}

//
//  AuthLogoutRequest.swift
//  
//
//  Created by Ramazan Ashurbekov on 02.01.2023.
//

import NetworkManagerInterface

struct AuthLogoutRequest: HTTPRequest {
    typealias Response = EmptyResponse

    var path: String {
        "/auth/token/logout/"
    }

    var method: HTTPMethod {
        .post
    }
}

struct EmptyResponse: Decodable {}

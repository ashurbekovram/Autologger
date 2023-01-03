//
//  AuthLoginRequest.swift
//  
//
//  Created by Ramazan Ashurbekov on 02.01.2023.
//

import Foundation
import NetworkManagerInterface

struct AuthLoginRequest: HTTPRequest {
    typealias Response = AuthLoginResponse

    var path: String {
        "/auth/token/login"
    }

    var method: HTTPMethod {
        .post
    }

    var bodyParams: [String : String] {
        [
            "username": username,
            "password": password,
        ]
    }

    let username: String
    let password: String
}

//
//  AuthLoginResponse.swift
//  
//
//  Created by Ramazan Ashurbekov on 03.01.2023.
//

struct AuthLoginResponse: Decodable {
    let authToken: String

    enum CodingKeys: String, CodingKey {
        case authToken = "auth_token"
    }
}

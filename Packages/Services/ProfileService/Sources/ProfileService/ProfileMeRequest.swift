//
//  ProfileMeRequest.swift
//  
//
//  Created by Ramazan Ashurbekov on 04.01.2023.
//

import Models
import NetworkManagerInterface

struct ProfileMeRequest: HTTPRequest {
    typealias Response = Profile

    var path: String {
        "/auth/users/me"
    }

    var method: HTTPMethod {
        .get
    }
}

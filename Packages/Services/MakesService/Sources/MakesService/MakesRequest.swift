//
//  MakesRequest.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

import Models
import NetworkManagerInterface

struct MakesRequest: HTTPRequest {
    typealias Response = [Make]

    var path: String {
        "/brands"
    }

    var parameters: [String : String] {
        [:]
    }

    var method: HTTPMethod {
        .get
    }
}

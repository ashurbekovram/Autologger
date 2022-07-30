//
//  MakesRequest.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

import Models
import NetworkManager

struct MakesRequest: HTTPRequest {
    typealias Response = [Make]

    var path: String {
        "/makes"
    }

    var parameters: [String : String] {
        [:]
    }

    var method: HTTPMethod {
        .get
    }
}

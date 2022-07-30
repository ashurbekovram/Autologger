//
//  VPICRequest.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

import Foundation
import NetworkManager

struct VPICRequest: HTTPRequest {
    typealias Response = VPICResponse

    var baseURL: String {
        "https://vpic.nhtsa.dot.gov/api/vehicles"
    }

    var path: String {
        "/getallmakes"
    }

    var parameters: [String : String] {
        ["format": "json"]
    }

    var method: HTTPMethod {
        .get
    }
}

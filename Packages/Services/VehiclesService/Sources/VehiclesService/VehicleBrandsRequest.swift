//
//  VehicleBrandsRequest.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

import Models
import NetworkManagerInterface

struct VehicleBrandsRequest: HTTPRequest {
    typealias Response = [VehicleBrand]

    var path: String {
        "/brands"
    }

    var method: HTTPMethod {
        .get
    }
}

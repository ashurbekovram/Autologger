//
//  VehiclesService.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

import Combine
import Models

public protocol VehiclesService {
    func fetchAllBrands() -> AnyPublisher<[VehicleBrand], Error>
}

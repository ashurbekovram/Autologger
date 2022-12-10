//
//  VehiclesServiceProtocol.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

import Combine
import Models

public protocol VehiclesServiceProtocol {
    func fetchAllBrands() -> AnyPublisher<[VehicleBrand], Error>
}

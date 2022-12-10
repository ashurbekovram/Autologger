//
//  VehiclesServiceMock.swift
//  AutologgerTests
//
//  Created by Ramazan Ashurbekov on 31.07.2022.
//

import Combine
import Models
import VehiclesServiceInterface

final class VehiclesServiceMock: VehiclesService {
    var brands: CurrentValueSubject<[VehicleBrand], Never> = .init([])

    func fetchAllBrands() -> AnyPublisher<[VehicleBrand], Error> {
        brands
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

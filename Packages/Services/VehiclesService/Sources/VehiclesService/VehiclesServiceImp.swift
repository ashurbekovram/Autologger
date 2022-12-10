//
//  VehiclesService.swift
//  
//
//  Created by Ramazan Ashurbekov on 09.07.2022.
//

import Combine
import VehiclesServiceInterface
import Models
import NetworkManagerInterface

public final class VehiclesServiceImp: VehiclesService {
    private let networkManager: NetworkManager

    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    public func fetchAllBrands() -> AnyPublisher<[VehicleBrand], Error> {
        let request = VehicleBrandsRequest()
        return networkManager.send(request: request)
    }
}

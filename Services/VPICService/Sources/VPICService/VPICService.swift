//
//  VPICService.swift
//  
//
//  Created by Ramazan Ashurbekov on 09.07.2022.
//

import Combine
import Models
import NetworkManager

public protocol VPICService {
    func fetchAllMakes() -> AnyPublisher<[VPICAutoMake], Error>
    func fetchVehicleTypes()
}

public final class VPICServiceImpl: VPICService {
    private let networkManager: NetworkManager

    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchAllMakes() {
        networkManager.send(request: VPICRequest())
            .map { response in
                response.results
            }
    }
}

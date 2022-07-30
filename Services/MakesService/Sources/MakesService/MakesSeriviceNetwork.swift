//
//  MakesSeriviceNetwork.swift
//  
//
//  Created by Ramazan Ashurbekov on 09.07.2022.
//

import Combine
import Models
import NetworkManager

public final class MakesSeriviceNetwork: MakesService{
    private let networkManager: NetworkManager

    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    public func fetchAllMakes() -> AnyPublisher<[Make], Error> {
        let request = MakesRequest()
        return networkManager.send(request: request)
    }
}

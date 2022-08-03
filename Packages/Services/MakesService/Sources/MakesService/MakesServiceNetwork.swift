//
//  MakesServiceNetwork.swift
//  
//
//  Created by Ramazan Ashurbekov on 09.07.2022.
//

import Combine
import Models
import NetworkManagerInterface

public final class MakesServiceNetwork: MakesService{
    private let networkManager: NetworkManager

    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    public func fetchAllMakes() -> AnyPublisher<[Make], Error> {
        let request = MakesRequest()
        return networkManager.send(request: request)
    }
}

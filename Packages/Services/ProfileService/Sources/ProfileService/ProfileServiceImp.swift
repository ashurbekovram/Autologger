//
//  ProfileServiceImp.swift
//  
//
//  Created by Ramazan Ashurbekov on 04.01.2023.
//

import Combine
import Foundation
import Models
import NetworkManagerInterface
import ProfileServiceInterface

public final class ProfileServiceImp: ProfileService {
    public var profile: CurrentValueSubject<Profile?, Never> = .init(nil)

    private let networkManager: NetworkManager

    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    public func fetchProfile() -> AnyPublisher<Void, Error> {
        let request = ProfileMeRequest()

        return networkManager
            .send(request: request)
            .map { _ in
                return ()
            }
            .eraseToAnyPublisher()
    }

    public func updateProfile(_ profile: Profile) -> AnyPublisher<Void, Error> {
        return Fail(error: URLError(.cancelled)).eraseToAnyPublisher()
    }
}

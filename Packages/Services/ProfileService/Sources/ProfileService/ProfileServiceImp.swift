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
    private var cancellableSet = Set<AnyCancellable>()

    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        bind()
    }

    public func fetchProfile() -> AnyPublisher<Void, Error> {
        let request = ProfileMeRequest()

        return networkManager
            .send(request: request)
            .receive(on: DispatchQueue.main)
            .map { [weak self] response in
                self?.profile.send(response)
                return ()
            }
            .eraseToAnyPublisher()
    }

    public func updateProfile(_ profile: Profile) -> AnyPublisher<Void, Error> {
        return Fail(error: URLError(.cancelled)).eraseToAnyPublisher()
    }

    private func bind() {
        networkManager.apiToken
            .removeDuplicates()
            .filter { $0 == nil }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.profile.send(nil)
            }
            .store(in: &cancellableSet)
    }
}

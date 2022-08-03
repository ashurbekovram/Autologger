//
//  ProfileServiceMock.swift
//  AutologgerTests
//
//  Created by Ramazan Ashurbekov on 31.07.2022.
//

import Combine
@testable import Models
@testable import ProfileServiceInterface

final class ProfileServiceMock: ProfileService {
    var profile: CurrentValueSubject<Profile?, Never> = .init(nil)

    func fetchProfile() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }

    func updateProfile(_ profile: Profile) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }
}

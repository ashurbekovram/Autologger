//
//  ProfileServiceMock.swift
//  AutologgerTests
//
//  Created by Ramazan Ashurbekov on 31.07.2022.
//

import Combine
@testable import Models
@testable import ProfileService

final class ProfileServiceMock: ProfileService {
    var profile: CurrentValueSubject<Profile?, Never> = .init(nil)

    var isFetchProfileCalled: Bool = false
    var isUpdateProfileCalled: Bool = false

    func fetchProfile() -> AnyPublisher<Void, Error> {
        isFetchProfileCalled = true
        return Future<Void, Error> { promise in
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }

    func updateProfile(_ profile: Profile) -> AnyPublisher<Void, Error> {
        isUpdateProfileCalled = true
        return Future<Void, Error> { promise in
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }
}

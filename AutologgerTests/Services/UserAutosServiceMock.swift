//
//  UserAutosServiceMock.swift
//  AutologgerTests
//
//  Created by Ramazan Ashurbekov on 31.07.2022.
//

import Combine
@testable import Models
@testable import UserAutosService

final class UserAutosServiceMock: UserAutosService {
    var userAutos: CurrentValueSubject<[Auto], Never> = .init([])

    func fetchUserAutos() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }

    func addNewAuto(_ auto: Auto) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }

    func removeAuto(_ auto: Auto) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }
}

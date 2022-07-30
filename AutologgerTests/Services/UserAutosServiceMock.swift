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

    var isFetchUserAutosCalled: Bool = false
    var isAddNewAutoCalled: Bool = false
    var isRemoveAutoCalled: Bool = false

    func fetchUserAutos() -> AnyPublisher<Void, Error> {
        isFetchUserAutosCalled = true
        return Future<Void, Error> { promise in
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }

    func addNewAuto(_ auto: Auto) -> AnyPublisher<Void, Error> {
        isAddNewAutoCalled = true
        return Future<Void, Error> { promise in
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }

    func removeAuto(_ auto: Auto) -> AnyPublisher<Void, Error> {
        isRemoveAutoCalled = true
        return Future<Void, Error> { promise in
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }
}

//
//  MakesServiceMock.swift
//  AutologgerTests
//
//  Created by Ramazan Ashurbekov on 31.07.2022.
//

import Combine
@testable import MakesService
@testable import Models

final class MakesServiceMock: MakesService {
    var makes: CurrentValueSubject<[Make], Never> = .init([])

    func fetchAllMakes() -> AnyPublisher<[Make], Error> {
        makes
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

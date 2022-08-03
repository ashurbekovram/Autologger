//
//  MakesServiceMock.swift
//  AutologgerTests
//
//  Created by Ramazan Ashurbekov on 31.07.2022.
//

import Combine
import Models
import MakesServiceInterface

final class MakesServiceMock: MakesService {
    var makes: CurrentValueSubject<[Make], Never> = .init([])

    func fetchAllMakes() -> AnyPublisher<[Make], Error> {
        makes
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

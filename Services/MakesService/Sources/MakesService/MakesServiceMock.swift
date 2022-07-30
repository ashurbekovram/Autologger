//
//  MakesServiceMock.swift
//  
//
//  Created by Ramazan Ashurbekov on 09.07.2022.
//

import Combine
import Models

public final class MakesServiceMock {
    public func fetchAllMakes() -> AnyPublisher<[Make], Error> {
        Future { promice in
            let makes: [Make] = [
                Make(id: 1000, name: "Audi"),
                Make(id: 1001, name: "BMW"),
                Make(id: 1002, name: "Mercedes-Benz"),
            ]
            promice(.success(makes))
        }
        .eraseToAnyPublisher()
    }
}

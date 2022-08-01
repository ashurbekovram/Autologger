//
//  MakesSerivice.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 02.07.2022.
//

import Combine
import Models

public protocol MakesService {
    func fetchAllMakes() -> AnyPublisher<[Make], Error>
}

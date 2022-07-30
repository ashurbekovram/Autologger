//
//  UserAutosService.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 15.07.2022.
//

import Combine
import Models

public protocol UserAutosService {
    var userAutos: CurrentValueSubject<[Auto], Never> { get }

    func fetchUserAutos() -> AnyPublisher<Void, Error>
    func addNewAuto(_ auto: Auto) -> AnyPublisher<Void, Error>
    func removeAuto(_ auto: Auto) -> AnyPublisher<Void, Error>
}

//
//  UserAutosServiceLocal.swift
//  
//
//  Created by Ramazan Ashurbekov on 15.07.2022.
//

import Combine
import Foundation
import Models

public final class UserAutosServiceLocal: UserAutosService {
    private let userDefaults = UserDefaults.standard
    private let userAutosKey = "udKeyUserAutos"

    public private(set) var userAutos: CurrentValueSubject<[Auto], Never> = .init([])

    public init() {}

    public func fetchUserAutos() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else {
                return
            }

            guard let userAutosData = self.userDefaults.data(forKey: self.userAutosKey) else {
                self.userAutos.value = []
                promise(.success(()))
                return
            }

            do {
                let userAutos = try JSONDecoder().decode([Auto].self, from: userAutosData)
                self.userAutos.value = userAutos
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .delay(for: 2, scheduler: DispatchQueue.global())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    public func addNewAuto(_ auto: Auto) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else {
                return
            }

            do {
                let userAutos = self.userAutos.value + [auto]
                let userAutosData = try JSONEncoder().encode(userAutos)
                self.userDefaults.set(userAutosData, forKey: self.userAutosKey)
                self.userAutos.value = userAutos
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    public func removeAuto(_ auto: Auto) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else {
                return
            }

            do {
                var userAutos = self.userAutos.value
                userAutos.removeAll { $0 == auto }

                let userAutosData = try JSONEncoder().encode(userAutos)
                self.userDefaults.set(userAutosData, forKey: self.userAutosKey)
                self.userAutos.value = userAutos
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}

//
//  ProfileServiceLocal.swift
//  
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import Combine
import Foundation
import Models
import ProfileServiceInterface

public final class ProfileServiceLocal: ProfileService {
    private let userDefaults = UserDefaults.standard
    private let profileKey = "udKeyProfile"

    public private(set) var profile: CurrentValueSubject<Profile?, Never> = .init(nil)

    public init() {}

    public func fetchProfile() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else {
                return
            }

            guard let profileData = self.userDefaults.data(forKey: self.profileKey) else {
                promise(.success(()))
                return
            }

            do {
                let profile = try JSONDecoder().decode(Profile.self, from: profileData)
                self.profile.value = profile
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .delay(for: 2, scheduler: DispatchQueue.global())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    public func updateProfile(_ profile: Profile) -> AnyPublisher<Void, Error>  {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else {
                return
            }

            do {
                let profileData = try JSONEncoder().encode(profile)
                self.userDefaults.set(profileData, forKey: self.profileKey)
                self.profile.value = profile
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}

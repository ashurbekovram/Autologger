//
//  ProfileService.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 10.07.2022.
//

import Combine
import Models

public protocol ProfileService {
    var profile: CurrentValueSubject<Profile?, Never> { get }
    var isProfileLoading: CurrentValueSubject<Bool, Never> { get }

    func fetchProfile() -> AnyPublisher<Void, Error>
    func updateProfile(_ profile: Profile) -> AnyPublisher<Void, Error>
}

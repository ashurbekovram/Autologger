//
//  ProfileServiceImp.swift
//  
//
//  Created by Ramazan Ashurbekov on 04.01.2023.
//

import Combine
import Foundation
import Models
import NetworkManagerInterface
import ProfileServiceInterface

public final class ProfileServiceImp: ProfileService {
    public private(set) var profile: CurrentValueSubject<Profile?, Never>
    public private(set) var isProfileLoading = CurrentValueSubject<Bool, Never>(false)

    private let networkManager: NetworkManager
    private var cancellableSet = Set<AnyCancellable>()

    public init(networkManager: NetworkManager) {
        self.profile = CurrentValueSubject<Profile?, Never>(ProfileStorage.load())
        self.networkManager = networkManager
        bind()
    }

    private var profileFetchingPublisher: AnyPublisher<Void, Error>?

    public func fetchProfile() -> AnyPublisher<Void, Error> {
        guard !isProfileLoading.value else {
            return profileFetchingPublisher ?? Fail(error: URLError(.cancelled)).eraseToAnyPublisher()
        }

        isProfileLoading.send(true)

        let request = ProfileMeRequest()
        let pp = networkManager
            .send(request: request)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { [weak self] completion in
                self?.isProfileLoading.send(false)
                return ()
            })
            .map { [weak self] response in
                ProfileStorage.save(response)
                self?.profile.send(response)
                return ()
            }
            .eraseToAnyPublisher()

        profileFetchingPublisher = pp
        return pp
    }

    public func updateProfile(_ profile: Profile) -> AnyPublisher<Void, Error> {
        return Fail(error: URLError(.cancelled)).eraseToAnyPublisher()
    }

    private func bind() {
        networkManager.apiToken
            .removeDuplicates()
            .filter { $0 == nil }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                ProfileStorage.clear()
                self?.profile.send(nil)
            }
            .store(in: &cancellableSet)
    }
}


// MARK: - Mock storage

final class ProfileStorage {
    static private let profileKey = "udKeyProfile"

    static func save(_ profile: Profile) {
        guard let profileData = try? JSONEncoder().encode(profile) else {
            return
        }
        UserDefaults.standard.set(profileData, forKey: ProfileStorage.profileKey)
    }

    static func load() -> Profile? {
        guard let profileData = UserDefaults.standard.data(forKey: ProfileStorage.profileKey) else {
            return nil
        }
        let profile = try? JSONDecoder().decode(Profile.self, from: profileData)
        return profile
    }

    static func clear() {
        UserDefaults.standard.removeObject(forKey: ProfileStorage.profileKey)
    }
}

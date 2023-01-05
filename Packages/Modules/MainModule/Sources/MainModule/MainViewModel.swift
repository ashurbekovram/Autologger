//
//  MainViewModel.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 09.07.2022.
//

import Combine
import Extensions
import Models
import ProfileServiceInterface
import SwiftUI
import UserAutosService

final class MainViewModel: ObservableObject {
    @Published private(set) var errorMessage: String?
    @Published private(set) var isProfileLoading: Bool = true
    @Published private(set) var isAutosLoading: Bool = true
    @Published private(set) var profile: Profile?
    @Published private(set) var autos: [Auto] = []

    let viewFactory: MainViewFactory

    private let profileService: ProfileService
    private let userAutosService: UserAutosService

    private var isFirstOpen: Bool = true
    private var cancellableSet = Set<AnyCancellable>()

    init(
        viewFactory: MainViewFactory,
        profileService: ProfileService,
        userAutosService: UserAutosService
    ) {
        self.viewFactory = viewFactory
        self.profileService = profileService
        self.userAutosService = userAutosService
        setupBindings()
        print("\(type(of: self)) init")
    }

    deinit {
        print("\(type(of: self)) deinit")
    }

    func onAppear() {
        guard isFirstOpen else {
            return
        }
        isFirstOpen = false

        loadProfile()
        loadUserAutos()
    }

    private func setupBindings() {
        profileService.isProfileLoading
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .assign(to: &$isProfileLoading)

        profileService.profile
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: &$profile)

        userAutosService.userAutos
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: &$autos)
    }

    private func loadProfile() {
        profileService
            .fetchProfile()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
            .store(in: &cancellableSet)
    }

    private func loadUserAutos() {
        isAutosLoading = true

        return userAutosService
            .fetchUserAutos()
            .receive(on: DispatchQueue.main)
            .weakSink(on: self) { strongSelf, completion in
                strongSelf.isAutosLoading = false
                switch completion {
                case .failure(let error):
                    strongSelf.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }
            .store(in: &cancellableSet)
    }
}

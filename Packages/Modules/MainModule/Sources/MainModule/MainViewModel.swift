//
//  MainViewModel.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 09.07.2022.
//

import Combine
import Extensions
import Foundation
import Models
import ProfileService
import SwiftUI
import UserAutosService

protocol MainViewModelProtocol: ObservableObject {
    var viewFactory: MainViewFactory? { get }

    var errorMessage: String? { get }
    var isProfileLoading: Bool { get }
    var isAutosLoading: Bool { get }
    var profile: Profile? { get }
    var autos: [Auto] { get }

    func onAppear()
}

final class MainViewModel: MainViewModelProtocol {
    @Published private(set) var errorMessage: String?
    @Published private(set) var isProfileLoading: Bool = true
    @Published private(set) var isAutosLoading: Bool = true
    @Published private(set) var profile: Profile?
    @Published private(set) var autos: [Auto] = []

    private(set) weak var viewFactory: MainViewFactory?

    private let profileService: ProfileService
    private let userAutosService: UserAutosService

    private var isFirstOpen: Bool = true
    private var cancellableSet = Set<AnyCancellable>()

    init(
        viewFactory: MainViewFactory?,
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
        profileService.profile
            .removeDuplicates()
            .assign(to: &$profile)

        userAutosService.userAutos
            .removeDuplicates()
            .assign(to: &$autos)
    }

    private func loadProfile() {
        isProfileLoading = true

        return profileService
            .fetchProfile()
            .sink { [weak self] completion in
                withAnimation {
                    self?.isProfileLoading = false
                }
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { _ in }
            .store(in: &cancellableSet)
    }

    private func loadUserAutos() {
        isAutosLoading = true

        return userAutosService
            .fetchUserAutos()
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

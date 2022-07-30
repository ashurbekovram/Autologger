//
//  MainViewModel.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 09.07.2022.
//

import Combine
import Foundation
import Models
import ProfileService
import SwiftUI
import UserAutosService

protocol MainViewModelProtocol: ObservableObject {
    var errorMessage: String? { get }
    var isProfileLoading: Bool { get }
    var isAutosLoading: Bool { get }
    var profile: Profile? { get }
    var autos: [Auto] { get }

    func onAppear()
    func createEditAutoView() -> AnyView
}

final class MainViewModel: MainViewModelProtocol {
    @Published private(set) var errorMessage: String?
    @Published private(set) var isProfileLoading: Bool = true
    @Published private(set) var isAutosLoading: Bool = true
    @Published private(set) var profile: Profile?
    @Published private(set) var autos: [Auto] = []

    private var isFirstOpen: Bool = true

    private let profileService: ProfileService
    private let userAutosService: UserAutosService
    private unowned var output: MainViewModelOutput

    private var cancellableSet = Set<AnyCancellable>()

    init(
        profileService: ProfileService,
        userAutosService: UserAutosService,
        output: MainViewModelOutput
    ) {
        self.profileService = profileService
        self.userAutosService = userAutosService
        self.output = output
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

    func createEditAutoView() -> AnyView {
        return output.createEditAutoView()
    }

    private func setupBindings() {
        profileService.profile
            .removeDuplicates()
            .print()
            .assign(to: &$profile)

        userAutosService.userAutos
            .removeDuplicates()
            .print()
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

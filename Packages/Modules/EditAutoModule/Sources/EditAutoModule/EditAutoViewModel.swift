//
//  EditAutoViewModel.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 01.07.2022.
//

import Combine
import Foundation
import MakesService
import Models
import UserAutosService

protocol EditAutoViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }
    var error: Error? { get }
    var makes: [Make] { get }
    var years: [Int] { get }

    var selectedMake: Make? { get set }
    var selectedYear: Int { get set }
    var model: String { get set }
    var vin: String { get set }

    func fetchMakes()
    func save()
}

final class EditAutoViewModel: EditAutoViewModelProtocol {
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var error: Error?
    @Published private(set) var makes: [Make] = []
    let years: [Int] = (1970...2022).map { $0 }

    @Published var selectedMake: Make?
    @Published var selectedYear: Int = 2000
    @Published var model: String = ""
    @Published var vin: String = ""

    private let makesService: MakesService
    private let userAutosService: UserAutosService
    private var cancellableSet = Set<AnyCancellable>()

    init(
        makesService: MakesService,
        userAutosService: UserAutosService
    ) {
        self.makesService = makesService
        self.userAutosService = userAutosService
        print("\(type(of: self)) init")
    }

    deinit {
        print("\(type(of: self)) deinit")
    }

    func fetchMakes() {
        isLoading = true
        makesService.fetchAllMakes()
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    break
                }
            } receiveValue: { [weak self] makes in
                self?.isLoading = false
                self?.makes = makes
            }
            .store(in: &cancellableSet)
    }

    func save() {
        guard let selectedMake = selectedMake else {
            return
        }

        let auto = Auto(
            brand: selectedMake.name,
            model: model,
            year: selectedYear,
            vin: vin
        )
        userAutosService.addNewAuto(auto)
            .sink { _ in
            } receiveValue: { _ in
            }
            .store(in: &cancellableSet)
    }
}

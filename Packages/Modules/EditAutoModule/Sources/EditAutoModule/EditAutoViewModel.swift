//
//  EditAutoViewModel.swift
//  Autologger
//
//  Created by Ramazan Ashurbekov on 01.07.2022.
//

import Combine
import Foundation
import VehiclesServiceInterface
import Models
import UserAutosService

final class EditAutoViewModel: ObservableObject {
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var error: Error?
    @Published private(set) var brands: [VehicleBrand] = []

    @Published var selectedBrand: VehicleBrand?
    @Published var selectedSeries: VehicleSeries?
    @Published var selectedGeneration: VehicleGeneration?
    @Published var selectedYear: Int?

    @Published var vin: String = ""

    // MARK: - Private properties

    private let vehiclesService: VehiclesService
    private let userAutosService: UserAutosService
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(
        vehiclesService: VehiclesService,
        userAutosService: UserAutosService
    ) {
        self.vehiclesService = vehiclesService
        self.userAutosService = userAutosService
        print("\(type(of: self)) init")
    }

    deinit {
        print("\(type(of: self)) deinit")
    }

    // MARK: - Internal methods

    func fetchBrands() {
        isLoading = true
        vehiclesService.fetchAllBrands()
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    break
                }
            } receiveValue: { [weak self] brands in
                self?.isLoading = false
                self?.brands = brands
            }
            .store(in: &cancellableSet)
    }

    func save() {
        guard let selectedBrand,
              let selectedSeries,
              let selectedGeneration,
              let selectedYear
        else {
            return
        }

        let auto = Auto(
            brand: selectedBrand.name,
            model: selectedSeries.name + " " + selectedGeneration.name,
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

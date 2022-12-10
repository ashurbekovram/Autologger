//
//  EditAutoViewModelTests.swift
//  AutologgerTests
//
//  Created by Ramazan Ashurbekov on 31.07.2022.
//

import Combine
import Models
import TestExtensions
import XCTest

@testable import Autologger
@testable import EditAutoModule
@testable import Models

final class EditAutoViewModelTests: XCTestCase {
    private var vehiclesService: VehiclesServiceMock!
    private var userAutosService: UserAutosServiceMock!
    private var editAutoViewModel: EditAutoViewModel!

    override func setUpWithError() throws {
        vehiclesService = VehiclesServiceMock()
        userAutosService = UserAutosServiceMock()
        editAutoViewModel = EditAutoViewModel(
            vehiclesService: vehiclesService,
            userAutosService: userAutosService
        )
    }

    override func tearDownWithError() throws {
        vehiclesService = nil
        userAutosService = nil
        editAutoViewModel = nil
    }

    func testFetchMakes() throws {
        let germany = Country(id: 1, name: "Germany")
        let stubBrands = [
            VehicleBrand(id: 1, name: "Audi", description: "", foundingDate: "1900", country: germany, series: []),
            VehicleBrand(id: 2, name: "BMW", description: "", foundingDate: "1900", country: germany, series: []),
            VehicleBrand(id: 3, name: "Mercedes-Benz", description: "", foundingDate: "1900", country: germany, series: []),
            VehicleBrand(id: 4, name: "Porsche", description: "", foundingDate: "1900", country: germany, series: []),
        ]
        vehiclesService.brands.send(stubBrands)

        editAutoViewModel.fetchMakes()

        let brands = try awaitPublisher(editAutoViewModel.$brands)
        XCTAssertEqual(brands, stubBrands)
    }

    func testSave() throws {
        let germany = Country(id: 1, name: "Germany")
        let stubSelectedBrand = VehicleBrand(id: 1, name: "Audi", description: "", foundingDate: "1900", country: germany, series: [])
        let stubModel = "RS7"
        let stubSelectedYear = 2017
        let stubVIN = "AAAAAAAAAAAA"
        let stubAuto = Auto(
            brand: stubSelectedBrand.name,
            model: stubModel,
            year: stubSelectedYear,
            vin: stubVIN
        )

        editAutoViewModel.selectedBrand = stubSelectedBrand
        editAutoViewModel.model = stubModel
        editAutoViewModel.selectedYear = stubSelectedYear
        editAutoViewModel.vin = stubVIN

        editAutoViewModel.save()

        let autos = try awaitPublisher(userAutosService.userAutos)
        XCTAssertEqual(autos.last, stubAuto)
    }
}

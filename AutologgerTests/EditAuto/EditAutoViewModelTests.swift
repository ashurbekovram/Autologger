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

        editAutoViewModel.fetchBrands()

        let brands = try awaitPublisher(editAutoViewModel.$brands)
        XCTAssertEqual(brands, stubBrands)
    }

    func testSave() throws {
        let stubYear = 2005
        let stubGeneration = VehicleGeneration(id: 1, name: "E60", startYear: 2003, endYear: 2010)
        let stubSeries = VehicleSeries(id: 1, name: "5 Series ", generations: [stubGeneration])
        let stubCountry = Country(id: 1, name: "Germany")
        let stubBrand = VehicleBrand(id: 1, name: "BMW", description: "", foundingDate: "1900", country: stubCountry, series: [stubSeries])
        let stubVIN = "AAAAAAAAAAAA"

        editAutoViewModel.selectedBrand = stubBrand
        editAutoViewModel.selectedSeries = stubSeries
        editAutoViewModel.selectedGeneration = stubGeneration
        editAutoViewModel.selectedYear = stubYear
        editAutoViewModel.vin = stubVIN

        editAutoViewModel.save()

        let autos = try awaitPublisher(userAutosService.userAutos)
        XCTAssertEqual(autos.last?.brand, stubBrand.name)
        XCTAssertEqual(autos.last?.model, stubSeries.name + " " + stubGeneration.name)
        XCTAssertEqual(autos.last?.year, stubYear)
        XCTAssertEqual(autos.last?.vin, stubVIN)
    }
}

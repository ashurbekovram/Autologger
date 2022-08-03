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

final class EditAutoViewModelTests: XCTestCase {
    private var makesService: MakesServiceMock!
    private var userAutosService: UserAutosServiceMock!
    private var editAutoViewModel: EditAutoViewModel!

    override func setUpWithError() throws {
        makesService = MakesServiceMock()
        userAutosService = UserAutosServiceMock()
        editAutoViewModel = EditAutoViewModel(
            makesService: makesService,
            userAutosService: userAutosService
        )
    }

    override func tearDownWithError() throws {
        makesService = nil
        userAutosService = nil
        editAutoViewModel = nil
    }

    func testFetchMakes() throws {
        let stubMakes = [
            Make(id: 1, name: "Audi"),
            Make(id: 2, name: "BMW"),
            Make(id: 3, name: "Mercedes-Benz"),
            Make(id: 4, name: "Porsche")
        ]
        makesService.makes.send(stubMakes)

        editAutoViewModel.fetchMakes()

        let makes = try awaitPublisher(editAutoViewModel.$makes)
        XCTAssertEqual(makes, stubMakes)
    }

    func testSave() throws {
        let stubSelectedMake = Make(id: 1, name: "Audi")
        let stubModel = "RS7"
        let stubSelectedYear = 2017
        let stubVIN = "AAAAAAAAAAAA"
        let stubAuto = Auto(
            brand: stubSelectedMake.name,
            model: stubModel,
            year: stubSelectedYear,
            vin: stubVIN
        )

        editAutoViewModel.selectedMake = stubSelectedMake
        editAutoViewModel.model = stubModel
        editAutoViewModel.selectedYear = stubSelectedYear
        editAutoViewModel.vin = stubVIN

        editAutoViewModel.save()

        let autos = try awaitPublisher(userAutosService.userAutos)
        XCTAssertEqual(autos.last, stubAuto)
    }
}

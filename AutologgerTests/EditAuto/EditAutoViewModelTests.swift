//
//  EditAutoViewModelTests.swift
//  AutologgerTests
//
//  Created by Ramazan Ashurbekov on 31.07.2022.
//

import Combine
import XCTest
@testable import Autologger

final class EditAutoViewModelTests: XCTestCase {
    private var makesService: MakesServiceMock!
    private var userAutosService: UserAutosServiceMock!
    private var editAutoViewModel: EditAutoViewModel!

    override func setUpWithError() throws {
        makesService = MakesServiceMock()
        userAutosService = UserAutosServiceMock()
        editAutoViewModel = EditAutoViewModel(makesService: makesService, userAutosService: userAutosService)
    }

    override func tearDownWithError() throws {
        makesService = nil
        userAutosService = nil
        editAutoViewModel = nil
    }

    func testFetchMakes() {

    }

    func testSave() {

    }
}

//
//  MainViewModelTests.swift
//  MainViewModelTests
//
//  Created by Ramazan Ashurbekov on 30.07.2022.
//

import XCTest
@testable import Autologger

final class MainViewModelTests: XCTestCase {

    var userAutosService: UserAutosServiceMock!
    var profileService: ProfileServiceMock!
    var mainViewModelOutput: MainViewModelOutputMock!
    var mainViewModel: MainViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        userAutosService = UserAutosServiceMock()
        profileService = ProfileServiceMock()
        mainViewModelOutput = MainViewModelOutputMock()
        mainViewModel = MainViewModel(
            profileService: profileService,
            userAutosService: userAutosService,
            output: mainViewModelOutput
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        userAutosService = nil
        profileService = nil
        mainViewModelOutput = nil
        mainViewModel = nil
    }

    func testOnAppear() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        mainViewModel.onAppear()

        XCTAssert(userAutosService.isFetchUserAutosCalled)
        XCTAssert(profileService.isFetchProfileCalled)
    }

    func testCreateEditAuto() {
        mainViewModel.createEditAutoView()

        XCTAssert(mainViewModelOutput.isCreateEditAutoViewCalled)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}

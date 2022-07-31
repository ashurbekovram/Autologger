//
//  MainViewModelTests.swift
//  MainViewModelTests
//
//  Created by Ramazan Ashurbekov on 30.07.2022.
//

import Combine
import XCTest

@testable import Autologger
@testable import Models

final class MainViewModelTests: XCTestCase {

    private var userAutosService: UserAutosServiceMock!
    private var profileService: ProfileServiceMock!
    private var mainViewModelOutput: MainViewModelOutputMock!
    private var mainViewModel: MainViewModel!

    private var cancellableSet = Set<AnyCancellable>()

    // Запускается перед каждым тестом
    override func setUpWithError() throws {
        userAutosService = UserAutosServiceMock()
        profileService = ProfileServiceMock()
        mainViewModelOutput = MainViewModelOutputMock()
        mainViewModel = MainViewModel(
            profileService: profileService,
            userAutosService: userAutosService,
            output: mainViewModelOutput
        )
    }

    // Запускается после каждого теста
    override func tearDownWithError() throws {
        userAutosService = nil
        profileService = nil
        mainViewModelOutput = nil
        mainViewModel = nil
    }

    func testOnAppear() {
        // given
        let stubProfile = Profile(name: "Name", secondName: "SecondName", imageURL: nil)
        let expectationProfile = XCTestExpectation(description: "Profile is loaded")
        mainViewModel.$profile
            .dropFirst()
            .sink { profile in
                XCTAssertEqual(profile, stubProfile)
                expectationProfile.fulfill()
            }
            .store(in: &cancellableSet)

        let stubAutos = [
            Auto(brand: "BMW", model: "330i", year: 2005, vin: "AAAAAAAAAA"),
            Auto(brand: "Porsche", model: "Panamera", year: 2018, vin: "AAAAAAAAAA")
        ]
        let expectationAutos = XCTestExpectation(description: "Autos is loaded")
        mainViewModel.$autos
            .dropFirst()
            .sink { autos in
                XCTAssertEqual(autos, stubAutos)
                expectationAutos.fulfill()
            }
            .store(in: &cancellableSet)

        profileService.profile.send(stubProfile)
        userAutosService.userAutos.send(stubAutos)

        // when
        mainViewModel.onAppear()

        // then
        wait(for: [expectationProfile, expectationAutos], timeout: 1)
    }

//    func testCreateEditAuto() {
//        mainViewModel.createEditAutoView()
//        XCTAssert(mainViewModelOutput.isCreateEditAutoViewCalled)
//    }
//
//    func testPerformanceExample() {
//        measure(metrics: [
//            XCTClockMetric(),
//            XCTCPUMetric(),
//            XCTStorageMetric(),
//            XCTMemoryMetric()
//        ]) {
//            mainViewModel.onAppear()
//        }
//    }
}

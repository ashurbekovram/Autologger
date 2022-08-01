import Combine
import Models
import TestExtensions
import XCTest

@testable import ProfileService

final class ProfileServiceTests: XCTestCase {
    private var profileService: ProfileService!

    override func setUpWithError() throws {
        profileService = ProfileServiceLocal()
    }

    override func tearDownWithError() throws {
        profileService = nil
    }

    func testUpdateProfile() throws {
        let stubProfile = Profile(name: "Name", secondName: "SecondName", imageURL: nil)

        let _ = profileService.updateProfile(stubProfile)
        let profile = try awaitPublisher(profileService.profile)

        XCTAssertEqual(stubProfile, profile)
    }
}

//
//  PlanrTests.swift
//  PlanrTests
//
//  Created by Blakeman, Mike on 8/25/21.
//

import XCTest
@testable import Planr

class ValidateEngineer: XCTestCase {

    // Test first name validation
    func testEngineerInvalidFirstNameLength() throws {
        let engineer = Engineer(firstName: "12345678901234567890123456789012345678900",
                                lastName: "Smith",
                                platform: [Platform.ios],
                                unavailableDates: [])

        var thrownError: Error?

        XCTAssertThrowsError(try engineer.validate()) { thrownError = $0 }
        XCTAssertTrue(thrownError is EngineerValidationError, "Unexpected Error Type: \(type(of: thrownError))")
        XCTAssertEqual(thrownError as? EngineerValidationError, .invalidFirstNameLength)
    }

    // Test last name validation
    func testEngineerInvalidLastNameLength() throws {
        let engineer = Engineer(firstName: "Derek",
                                lastName: "12345678901234567890123456789012345678900",
                                platform: [Platform.ios],
                                unavailableDates: [])

        var thrownError: Error?

        XCTAssertThrowsError(try engineer.validate()) { thrownError = $0 }
        XCTAssertTrue(thrownError is EngineerValidationError, "Unexpected Error Type: \(type(of: thrownError))")
        XCTAssertEqual(thrownError as? EngineerValidationError, .invalidLastNameLength)
    }

    // Test platform validation
    func testEngineerInvalidPlatformLength() throws {
        let engineer = Engineer(firstName: "Derek",
                                lastName: "Smith",
                                platform: [],
                                unavailableDates: [])

        var thrownError: Error?

        XCTAssertThrowsError(try engineer.validate()) { thrownError = $0 }
        XCTAssertTrue(thrownError is EngineerValidationError, "Unexpected Error Type: \(type(of: thrownError))")
        XCTAssertEqual(thrownError as? EngineerValidationError, .invalidPlatformLength)
    }

    // Test platform duplicate validation
    func testEngineerInvalidDuplicatePlatform() throws {
        let engineer = Engineer(firstName: "Derek",
                                lastName: "Smith",
                                platform: [Platform.ios, Platform.ios],
                                unavailableDates: [])

        var thrownError: Error?

        XCTAssertThrowsError(try engineer.validate()) { thrownError = $0 }
        XCTAssertTrue(thrownError is EngineerValidationError, "Unexpected Error Type: \(type(of: thrownError))")
        XCTAssertEqual(thrownError as? EngineerValidationError, .invalidPlatformDuplicates)
    }

    func testEngineerUnavailableDateBeforeToday() throws {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let engineer = Engineer(firstName: "Derek",
                                lastName: "Smith",
                                platform: [Platform.ios],
                                unavailableDates: [yesterday!])

        var thrownError: Error?

        XCTAssertThrowsError(try engineer.validate()) { thrownError = $0 }
        XCTAssertTrue(thrownError is EngineerValidationError, "Unexpected Error Type: \(type(of: thrownError))")
        XCTAssertEqual(thrownError as? EngineerValidationError, .invalidUnavailableDate)
    }

    func testEngineerUnavailableDateToday() throws {
        let engineer = Engineer(firstName: "Derek",
                                lastName: "Smith",
                                platform: [Platform.ios],
                                unavailableDates: [Date()])

        XCTAssertTrue(try engineer.validate())
    }
}

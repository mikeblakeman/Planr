//
//  ProjectValidationTests.swift
//  PlanrTests
//
//  Created by Blakeman, Mike on 8/25/21.
//

import XCTest
import RealmSwift
@testable import Planr

class ValidateProject: XCTestCase {

    // Test first name validation
    func testProjectFeatureNameEmptyLength() throws {
        let feature = UnplannedFeature(name: "",
                                       nil,
                                       platform: [PlatformType.ios],
                                       effortEstimate: 26,
                                       priority: 100)

//        var thrownError: Error?
//        XCTAssertThrowsError(try feature.validate()) { thrownError = $0 }
//
//        XCTAssertTrue(
//            thrownError is FeatureValidationError,
//            "Unexpected Error Type: \(type(of: thrownError))"
//        )
//
//        XCTAssertEqual(thrownError as? FeatureValidationError, .invalidFeatureNameLengthError)
    }

    func testProjectFeatureNameTooLong() throws {
        let feature = UnplannedFeature(name: "12345678901234567890123456789012345678901",
                              nil,
                              platform: [PlatformType.ios],
                              effortEstimate: 26,
                              priority: 100)

//        var thrownError: Error?
//        XCTAssertThrowsError(try feature.validate()) { thrownError = $0 }
//
//        XCTAssertTrue(
//            thrownError is FeatureValidationError,
//            "Unexpected Error Type: \(type(of: thrownError))"
//        )
//
//        XCTAssertEqual(thrownError as? FeatureValidationError, .invalidFeatureNameLengthError)
    }

    // Test last name validation
    func testProjectFeatureSummaryLength() throws {
        let feature = UnplannedFeature(name: "feature",
                              "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456" +
                              "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456" +
                              "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456" +
                              "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456",
                              platform: [PlatformType.ios],
                              effortEstimate: 26,
                              priority: 100)

//        var thrownError: Error?
//        XCTAssertThrowsError(try feature.validate()) { thrownError = $0 }
//
//        XCTAssertTrue(
//            thrownError is FeatureValidationError,
//            "Unexpected Error Type: \(type(of: thrownError))"
//        )
//
//        XCTAssertEqual(thrownError as? FeatureValidationError, .invalidFeatureSummaryLengthError)
    }

    // Test platform validation
    func testProjectFeaturePlatformEmptyCollection() throws {
        let engineer = Engineer(firstName: "Derek",
                                lastName: "Smith",
                                platform: [],
                                unavailableDates: [])

//        var thrownError: Error?
//        XCTAssertThrowsError(try engineer.validate()) { thrownError = $0 }
//
//        XCTAssertTrue(
//            thrownError is EngineerValidationError,
//            "Unexpected Error Type: \(type(of: thrownError))"
//        )
//
//        XCTAssertEqual(thrownError as? EngineerValidationError, .invalidPlatformLength)
    }

    // Test platform duplicate validation
    func testProjectFeaturePlatformDuplicate() throws {
        let engineer = Engineer(firstName: "Derek",
                                lastName: "Smith",
                                platform: [PlatformType.ios, PlatformType.ios],
                                unavailableDates: [])

//        var thrownError: Error?
//        XCTAssertThrowsError(try engineer.validate()) { thrownError = $0 }
//
//        XCTAssertTrue(
//            thrownError is EngineerValidationError,
//            "Unexpected Error Type: \(type(of: thrownError))"
//        )
//
//        XCTAssertEqual(thrownError as? EngineerValidationError, .invalidPlatformDuplicates)
    }

    func testProjectEffortSizeTooBig() throws {
        let engineer = Engineer(firstName: "Derek",
                                lastName: "Smith",
                                platform: [PlatformType.ios, PlatformType.ios],
                                unavailableDates: [])

//        var thrownError: Error?
//        XCTAssertThrowsError(try engineer.validate()) { thrownError = $0 }
//
//        XCTAssertTrue(
//            thrownError is EngineerValidationError,
//            "Unexpected Error Type: \(type(of: thrownError))"
//        )
//
//        XCTAssertEqual(thrownError as? EngineerValidationError, .invalidPlatformDuplicates)
    }

//    func testProjectPrioritySizeTooBig() throws {
//        let engineer = Engineer(firstName: "Derek",
//                                lastName: "Smith",
//                                platform: [Platform.ios, Platform.ios],
//                                unavailableDates: [])
//
//        var thrownError: Error?
//        XCTAssertThrowsError()
//    }
}

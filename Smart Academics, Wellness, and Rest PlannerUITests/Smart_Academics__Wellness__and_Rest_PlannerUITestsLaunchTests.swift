//
//  Smart_Academics__Wellness__and_Rest_PlannerUITestsLaunchTests.swift
//  Smart Academics, Wellness, and Rest PlannerUITests
//
//  Created by Haley Marts on 2/21/24.
//

import XCTest

final class Smart_Academics__Wellness__and_Rest_PlannerUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

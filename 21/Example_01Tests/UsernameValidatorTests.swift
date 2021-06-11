//
//  UsernameValidatorTests.swift
//  Example_01Tests
//
//  Created by Aleksandr Sychev on 18/05/2021.
//  Copyright © 2019 Aleksandr Sychev. All rights reserved.
//

import XCTest
@testable import Example_01

class UsernameValidatorTests: XCTestCase {

	func testTooShortUsername() {
		let sut = UsernameValidator()

		let result = sut.isValid("U1")

		XCTAssertFalse(result, "Произошла ошибка")
	}

	func testCorrectUsername() {
		
	}
}

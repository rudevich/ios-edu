//
//  _2_workTests.swift
//  22.workTests
//
//  Created by 18495524 on 6/11/21.
//



import XCTest
@testable import _2_work

class DummyApple:ProtocolApple {
    func slice() -> Int {
        fatalError("apple.slice")
    }
}


class _2_workTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // arrange
        let apple = DummyApple()
        // act
        let basket = Basket().build(apple: apple)
        // assert
        XCTAssertNotNil(basket)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

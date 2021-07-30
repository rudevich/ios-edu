//
//  SpinnerViewControllerTests.swift
//  NoteDrawTests
//
//  Created by 18495524 on 7/30/21.
//

import XCTest
@testable import NoteDraw

class DrawViewControllerTests: XCTestCase {
    
    var drawViewController = DrawViewController(dataSource: DrawViewModel())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatThereIsNoShapesAtCanvas() throws {
        
        XCTAssertEqual(drawViewController.canvas.shapes.count, 0)
    }
    

}

//
//  NoteDrawTests.swift
//  NoteDrawTests
//
//  Created by 18495524 on 7/30/21.
//

import XCTest
@testable import NoteDraw

class ImagesCollectionCellTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatImagesCollectionCellRequireConstraintBasedLayour() throws {
        XCTAssertTrue(ImagesCollectionCell.requiresConstraintBasedLayout, "cell is underlying on constraints")
    }
    
    func testThatImagesCollectionCellHasLabelAndImageView() throws {
        let cell = ImagesCollectionCell.init(frame: .zero)
        let isUILabel = type(of: cell.label) == UILabel.self
        let isUIImageView = type(of: cell.imageView) == UIImageView.self
        let isOk = isUILabel && isUIImageView
        XCTAssertTrue(isOk, "cell has image and label")
    }

}

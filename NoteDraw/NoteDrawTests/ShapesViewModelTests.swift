//
//  ShapesViewModel.swift
//  NoteDrawTests
//
//  Created by 18495524 on 7/30/21.
//

import XCTest
@testable import NoteDraw

class ShapesViewModelTests: XCTestCase {

    var shapes = Shapes()
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatShapesAreEmptyAtStart() throws {
        XCTAssertEqual(shapes.count, 0, "shapes are empty at start")
    }
    
    func testThatShapesCompletionIsInvokedAfterAddingShape() throws {
        // arrange
        let grapes = Shapes()
        var notEmpty = false
        grapes.completion = {
            notEmpty = $0
        }
        
        // act
        grapes.push(at: .zero, color: .clear, lineWidth: .zero, tool: "guitar")
        
        // assert
        XCTAssertTrue(notEmpty, "shapes completion for adding items is working")
    }
    
    func testThatShapesCompletionIsInvokedAfterCleared() throws {
        // arrange
        let grapes = Shapes()
        grapes.push(at: .zero, color: .clear, lineWidth: .zero, tool: "guitar")
        var notEmpty = true
        grapes.pop()
        grapes.completion = {
            notEmpty = $0
        }
        
        // act
        
        //assert
        XCTAssertTrue(notEmpty, "shapes completion for clearing items is working")
    }
    
    func testThatDefaultToolForShapesIsFreedraw() throws {
        
        // arrange
        let grapes = Shapes()
        grapes.push(at: .zero, color: .clear, lineWidth: .zero, tool: "guitar")

        // act
        let tool = grapes.last?.getTool() ?? ""
        
        //assert
        XCTAssertTrue(tool == "freedraw", "shapes default tool is freedraw")
    }
    
    func testThatToolSettedCorrectlyForEllipse() throws {
        // arrange
        let grapes = Shapes()
        grapes.push(at: .zero, color: .clear, lineWidth: .zero, tool: "ellipse")

        // act
        let tool = grapes.last?.getTool() ?? ""
        
        // assert
        XCTAssertTrue(tool == "ellipse", "shapes ellipse tool is set ok")
    }
    
    func testThatToolSettedCorrectlyForRect() throws {
        // arrange
        let grapes = Shapes()
        grapes.push(at: .zero, color: .clear, lineWidth: .zero, tool: "rect")

        // act
        let tool = grapes.last?.getTool() ?? ""
        
        // assert
        XCTAssertTrue(tool == "rect", "shapes rect tool is set ok")
    }
    
    func testThatToolSettedCorrectlyForSquare() throws {
        // arrange
        let grapes = Shapes()
        grapes.push(at: .zero, color: .clear, lineWidth: .zero, tool: "square")

        // act
        let tool = grapes.last?.getTool() ?? ""
        
        // assert
        XCTAssertTrue(tool == "square", "shapes square tool is set ok")
    }
    
    func testThatToolSettedCorrectlyForTriangle() throws {
        // arrange
        let grapes = Shapes()
        grapes.push(at: .zero, color: .clear, lineWidth: .zero, tool: "triangle")

        // act
        let tool = grapes.last?.getTool() ?? ""
        
        // assert
        XCTAssertTrue(tool == "triangle", "shapes square tool is set ok")
    }
    
    func testThatToolSettedCorrectlyForLine() throws {
        // arrange
        let grapes = Shapes()
        grapes.push(at: .zero, color: .clear, lineWidth: .zero, tool: "line")

        // act
        let tool = grapes.last?.getTool() ?? ""
        
        // assert
        XCTAssertTrue(tool == "line", "shapes square tool is set ok")
    }

}


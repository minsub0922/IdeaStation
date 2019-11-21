//
//  IdeaStationTests.swift
//  IdeaStationTests
//
//  Created by 최민섭 on 11/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import XCTest
@testable import IdeaStation

class IdeaStationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
//    
//    func testMDKeywordsArray() {
//        var a = [Array(arrayLiteral: 0...10)].enumerated()
//        var nestedArray = [Array(arrayLiteral: 0...10)].enumerated().map{ MDKeyword(index: $0.offset) }
//        //var array: [[MDKeyword]] = [[MDKeyword]].init(repeating: nestedArray, count: 3)
//        print(a)
//        print(nestedArray.count)
//    }

    func testPerformanceExample() {
       print("hellow?????")
    }
    
    func testReduceFunction() {
        let strings = ["사랑", "안전", "가시"]
        let s = strings.reduce("") { $0 + $1 + " " }
        print(s)
    }
}

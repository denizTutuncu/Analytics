//
//  AnalyticsTests.swift
//  AnalyticsTests
//
//  Created by Deniz Tutuncu on 10/19/21.
//

import XCTest

class Analytics {}

class AnalyticsTests: XCTestCase {
    
    func test_init_SUTNotNil() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> Analytics {
        let sut = Analytics()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

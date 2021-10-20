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
        let sut = Analytics()
        
        XCTAssertNotNil(sut)
    }
    
    
}

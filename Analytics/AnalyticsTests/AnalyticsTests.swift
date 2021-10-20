//
//  AnalyticsTests.swift
//  AnalyticsTests
//
//  Created by Deniz Tutuncu on 10/19/21.
//

import XCTest

enum EventType: Hashable {
    case UserSignedIn
    case TaskCreated
    case TaskCompleted
}

typealias Events = [String: [EventType : Int]]

class Analytics {
    
    init() {}
    
    var events: Events {
        return eventsDataModel
    }
    
    private var eventsDataModel = Events()
}

class AnalyticsTests: XCTestCase {
    
    func test_init_SUTNotNil() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut)
    }
    
    func test_init_eventsIsEmpty() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.events.count, 0)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> Analytics {
        let sut = Analytics()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

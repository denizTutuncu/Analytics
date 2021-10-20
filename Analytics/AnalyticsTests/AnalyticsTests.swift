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
    
    func track(eventType: EventType, creationDate: Date = Date()) {
        let creationDateAsString = creationDate.convertToString()
        eventsDataModel.updateValue([eventType:1], forKey: creationDateAsString)
    }
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
    
    func test_track_addsNewEventType() {
        let sut = makeSUT()
        
        sut.track(eventType: .UserSignedIn)
        
        XCTAssertEqual(sut.events.count, 1)
    }
    
    func test_track_addsNewEventType_WithTheCorrectDate() {
        let sut = makeSUT()
        
        let (sept_3_2021, sept_3_2021_AsString) = fixedDateAndStringRepresentation()
        sut.track(eventType: .UserSignedIn, creationDate: sept_3_2021)
        
        XCTAssertEqual(sut.events.keys.contains(sept_3_2021_AsString), true)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> Analytics {
        let sut = Analytics()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func fixedDateAndStringRepresentation() -> (sept_3_2021: Date, sept_3_2021_AsString: String) {
        let sept_3_2021 = DateHelper.fixedDate()
        let sept_3_2021_AsString = sept_3_2021.convertToString()
        return (sept_3_2021, sept_3_2021_AsString)
    }
}

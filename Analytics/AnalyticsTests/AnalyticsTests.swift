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
        updateEventsWith(eventType: eventType, creationDate: creationDate)
    }
    
    private func updateEventsWith(eventType: EventType, creationDate: Date) {
        let dateAsString = creationDate.convertToString()
        
        updateEvents(eventType: eventType, dateAsString: dateAsString)
    }
    
    private func updateEvents(eventType: EventType, dateAsString: String) {
        if !eventsDataModel.keys.contains(dateAsString) {
            addNewDateWith(eventType, dateAsString: dateAsString)
        } else {
            updateEventTypeCount(eventType, dateAsString)
        }
    }
    
    private func addNewDateWith(_ eventType: EventType, dateAsString: String) {
        eventsDataModel.updateValue([eventType:1], forKey: dateAsString)
    }
    
    private func updateEventTypeCount(_ eventType: EventType, _ creationDateAsString: String) {
        let eventCount = eventsDataModel[creationDateAsString]?[eventType]
        
        switch eventCount {
        case let .some(count):
            eventsDataModel[creationDateAsString]?[eventType] = count + 1
        case .none:
            eventsDataModel[creationDateAsString]?[eventType] = 1
        }
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
    
    func test_track_addsCorrectEventTypee_toSUTEvents() {
        let sut = makeSUT()
        
        let (sept_3_2021, sept_3_2021_AsString) = fixedDateAndStringRepresentation()
        sut.track(eventType: .UserSignedIn, creationDate: sept_3_2021)
        
        let eventType = sut.events[sept_3_2021_AsString]
        let key = eventType?.keys.first
        
        XCTAssertEqual(key, .UserSignedIn)
    }
    
    func test_trackTwice_OnSameDay_withDifferentEventTypes_SUTEventsContains_OneKeyForCreationDate() {
        let sut = makeSUT()
        
        let (sept_3_2021, _) = fixedDateAndStringRepresentation()
        let taskCreatedDate = sept_3_2021.addOneHour()
        
        sut.track(eventType: .UserSignedIn, creationDate: sept_3_2021)
        sut.track(eventType: .TaskCreated, creationDate: taskCreatedDate)
        
        XCTAssertEqual(sut.events.count, 1)
    }
    
    func test_trackTwice_onSameDay_withDifferentEventTypes_SUTContains_TwoEventTypes_onTheSameDay() {
        let sut = makeSUT()
        
        let (sept_3_2021, sept_3_2021_AsString) = fixedDateAndStringRepresentation()
        let taskCreatedDate = sept_3_2021.addOneHour()
        
        sut.track(eventType: .UserSignedIn, creationDate: sept_3_2021)
        sut.track(eventType: .TaskCreated, creationDate: taskCreatedDate)
        
        let eventsOnDate = sut.events[sept_3_2021_AsString]
        
        XCTAssertEqual(eventsOnDate!.count, 2)
    }
    
    func test_trackTwice_onDifferentDays_withDifferentEvents_SUTEventsContains_TwoKeysForDifferentDays() {
        let sut = makeSUT()
        
        let (sept_3_2021, _) = fixedDateAndStringRepresentation()
        let taskCreatedDate = sept_3_2021.adding(days: 1)
        
        sut.track(eventType: .UserSignedIn, creationDate: sept_3_2021)
        sut.track(eventType: .TaskCreated, creationDate: taskCreatedDate)
        
        XCTAssertEqual(sut.events.count, 2)
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

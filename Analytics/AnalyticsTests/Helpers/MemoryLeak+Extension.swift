//
//  MemoryLeak+Extension.swift
//  AnalyticsTests
//
//  Created by Deniz Tutuncu on 10/19/21.
//

import XCTest
extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should be deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}

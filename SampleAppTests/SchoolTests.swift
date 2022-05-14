//
//  SchoolTests.swift
//  SampleAppTests
//
//  Created by Ramazan Demir on 15.06.2021.
//

import XCTest

@testable import SampleApp

class SchoolTests: XCTestCase {
        
    // Mock students
    private let student1 = Student(name: "#1", grades: [2.0, 3.5, 4.0])
    private let student2 = Student(name: "#2", grades: [4.0, 4.0, 4.0])
    private let student3 = Student(name: "#3", grades: [1.0, 1.5])
    private let student4 = Student(name: "#4", grades: [])
    private let student5 = Student(name: "#5", grades: [4.0, 4.0, 4.0])
    
    // MARK: - topStudents (computed variable)
    
    /// Scenario with no students at all
    func testTopStudentsWithNoStudents() {
        let school = School(students: [])
        XCTAssertTrue(school.topStudents.isEmpty)
    }

    /// Scenario with no top students
    func testTopStudentsWithNoTopStudents() {
        let school = School(students: [student1, student3, student4])
        XCTAssertTrue(school.topStudents.isEmpty)
    }
    
    /// Scenario with two top students (#2 and #5)
    func testTopStudentsWithTwoTopStudents() {
        let school = School(students: [student1, student2, student3, student4, student5])
        let topStudents = school.topStudents
        XCTAssertFalse(topStudents.isEmpty)
        XCTAssertEqual(topStudents.count, 2)
        XCTAssertEqual(topStudents.first?.name, "#2")
        XCTAssertEqual(topStudents.last?.name, "#5")
    }
    
    /// Scenario with one top student (#2)
    func testTopStudentsWithOneTopStudent() {
        let school = School(students: [student1, student2, student3, student4])
        let topStudents = school.topStudents
        XCTAssertFalse(topStudents.isEmpty)
        XCTAssertEqual(topStudents.count, 1)
        XCTAssertEqual(topStudents.first?.name, "#2")
    }
      
    /// Retrieving the alumni should fetch the two alumni for the school.
     func testRetrieveAlumni() {
        var result: ([Student]?, Error?)?
        
        // Create the expectation.
        let expectation = self.expectation(description: "Waiting for the retrieveAlumni call to complete.")
        
        School(students: []).retrieveAlumni { (students, error) in
            guard error == nil else {
                XCTFail()
                return
            }
            result = (students, nil)
            expectation.fulfill()
        }
        
        // Wait for expectations for a maximum of 5 seconds.
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            
            // Http request succeeded, expect error is nil!
            guard result?.1 == nil else {
                XCTFail()
                return
            }
            XCTAssertEqual(result?.0?.count ?? 0, 3)
        }
     }
    
    
    func testDoSomethingAsynhronous() {
        // Create our test queue
        let queue = DispatchQueue(label: "test-queue")
        
        // didComplete is initially false.
        XCTAssertFalse(School.didComplete)
            
        // Inject our test queue.
        School(students: []).doSomethingAsynchronous(queue: queue)
        
        // Synchronize the queue to wait for it to complete.
        queue.sync { /* Do nothing, just synchronize */ }
        
        // didComplete should now be true.
        XCTAssertTrue(School.didComplete)
    }
    
    
}

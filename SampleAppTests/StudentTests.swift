//
//  StudentTests.swift
//  SampleAppTests
//
//  Created by Ramazan Demir on 15.06.2021.
//

import XCTest

@testable import SampleApp

class StudentTests: XCTestCase {
    
    // MARK: - gpa (computed property)
    
    // Students with no grades should not have a GPA.
    func testGPAWithNoGrades() {
        let student = Student(name: "test", grades: [])
        XCTAssertNil(student.gpa)
    }
    
    // If there is only one grade, the GPA should be equal to the grade.
    func testGPAWithOneGrade() {
        let student = Student(name: "test", grades: [4])
        XCTAssertEqual(student.gpa, 4)
    }

    // The GPA should correctly average with ten grades.
    func testGPAWithTenGrades() {
        let student = Student(name: "test", grades: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        XCTAssertEqual(student.gpa, 5.5)
    }
    
    // The GPA should correctly average - even with extreme grades.
    func testGPAWithExtremeNumbers() {
        let student = Student(name: "test", grades: [Float(Int.min), Float(Int.max)])
        XCTAssertEqual(student.gpa, 0)
    }
}

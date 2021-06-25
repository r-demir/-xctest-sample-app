//
//  Student.swift
//  SampleApp
//
//  Created by Ramazan Demir on 15.06.2021.
//

import Foundation
import ObjectMapper

class Student: Mappable {
    
    /// The name of the student.
    var name: String?
    
    /// The list of all grades for the student.
    var grades: [Float]?
    
    /// The current grade point average of the student.
    var gpa: Float? {
        guard !grades!.isEmpty else { return nil }
        return grades!.reduce(0, +) / Float(grades!.count)
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["name"]
        grades <- map["grades"]
    }
    
    init(name: String, grades: [Float]) {
        self.name = name
        self.grades = grades
    }
}

//
//  School.swift
//  SampleApp
//
//  Created by Ramazan Demir on 15.06.2021.
//

import Foundation
import AlamofireObjectMapper
import Alamofire


struct School {
    
    /// Enrolled students.
    var students: [Student] = []
    
    /// The top students are defined as students with a GPA >= 4.0.
    var topStudents: [Student] { students(withGPALimit: 4.0) }
    
    static var didComplete = false
    
    init() { }
    
    init(students: [Student]) {
        self.init()
        self.students = students
    }
    
    func doSomethingAsynchronous(queue: DispatchQueue = DispatchQueue(label: "some queue")) {
        School.didComplete = false
        queue.async {
            sleep(1)
            School.didComplete = true
        }
    }

    
}

extension School {
    
    func students(withGPALimit gpa: Float) -> [Student] {
        students.filter {
            guard let studentGPA = $0.gpa else { return false }
            return studentGPA >= gpa
        }
    }
    
    func retrieveAlumni(_ completion: @escaping ([Student]?, Error?)  -> Void ) {
        Alamofire.request("https://mocki.io/v1/72744af7-2b4c-44e9-a346-311d050b0ae9").responseArray { (response: DataResponse<[Student]>) in
            completion(response.result.value, response.error)
        }
    }
    
}

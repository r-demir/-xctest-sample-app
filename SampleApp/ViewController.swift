//
//  ViewController.swift
//  SampleApp
//
//  Created by Ramazan Demir on 15.06.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func documentTouched(_ sender: UIButton, forEvent event: UIEvent) {
        School().retrieveAlumni { (students, error) in
            guard error == nil else {
                print("Error: \(error?.localizedDescription)")
                return
            }
            if let students = students {
                print("Students fetched successfully!")
                print(students)
            }
        }
    }
    
}


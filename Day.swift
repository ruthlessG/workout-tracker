//
//  Day.swift
//  Workout3
//
//  Created by 108 on 24.03.16.
//
//


import UIKit

class Day {
    
    // MARK: Properties
    
    var name: String
    var date: String
    
    // MARK: Initialization
    
    init?(name: String, date: String) {
        // Initialize stored properties.
        self.name = name
        self.date = date
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty {
            return nil
        }
    }
}

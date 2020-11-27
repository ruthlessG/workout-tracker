//
//  Workout.swift
//  Workout3
//
//  Created by 108 on 30.03.16.
//
//

import UIKit

class Workout {
    
    // MARK: Properties
    
    // will be displayed in a cell in workouts list
    var name: String
    var date: String
    
    // this is supposed to be the content of tableview  (specifically each cell) in Workout Details (i.e. TestViewController...)
    var exercises: [Exercise]
    
    
    // MARK: Initialization
    
    init?(name: String, date: String, exercises: [Exercise]) {
        // Initialize stored properties.
        self.name = name
        self.date = date
        self.exercises = exercises
        
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty {
            return nil
        }
    }
}
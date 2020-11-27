//
//  Ex.swift
//  Workout3
//
//  Created by 108 on 28.03.16.
//
//

import UIKit

class Ex {
    // MARK: Properties
    
    var exercise: String
    var weightxreps: String
    
    // track the x coordinate of labels
    var xlabel: CGFloat
    
    
    
    // MARK: Initialization
    
    init?(exercise: String, weightxreps: String, xlabel: CGFloat) {
        // Initialize stored properties.
        self.exercise = exercise
        self.weightxreps = weightxreps
        self.xlabel = xlabel
        
        
    }
    
}

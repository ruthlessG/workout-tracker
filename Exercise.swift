//
//  Exercise.swift
//  Workout3
//
//  Created by 108 on 24.03.16.
//
//

import UIKit

class Exercise {
    // MARK: Properties
    
    var name: String
    var setsxreps: String
    
    var xlabel: CGFloat
    var ylabel: CGFloat
    
    var labelRows: CGFloat

    var labelArray: [UILabel]
    
    // MARK: Initialization
    
    
    init?(name: String, setsxreps: String, xlabel: CGFloat, ylabel: CGFloat, labelRows: CGFloat, labelArray: [UILabel]) {
        // Initialize stored properties.
        self.name = name
        self.setsxreps = setsxreps
        
        self.xlabel = xlabel
        self.ylabel = ylabel
        
        self.labelRows = labelRows
        
        //
        self.labelArray = labelArray
        
        // Initialization should fail if there is no name or if the rating is negative.
        //if name.isEmpty {
        //    return nil
        //}
    }
    
}

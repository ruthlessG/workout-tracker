//
//  ExTableViewCell.swift
//  Workout3
//
//  Created by 108 on 28.03.16.
//
//

import UIKit

class ExTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var exTextField: UITextField!
    
    //@IBOutlet weak var weightxrepsLabel: UILabel!
    
    @IBOutlet weak var weightxrepsView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

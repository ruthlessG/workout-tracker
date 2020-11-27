//
//  DayTableViewCell.swift
//  Workout3
//
//  Created by 108 on 24.03.16.
//
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

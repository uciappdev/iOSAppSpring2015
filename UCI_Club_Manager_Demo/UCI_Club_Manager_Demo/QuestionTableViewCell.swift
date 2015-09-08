//
//  QuestionTableViewCell.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/7/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var time_stamp: UILabel!
    
    @IBOutlet weak var question: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

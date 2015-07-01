//
//  CustomTableViewCell.swift
//  TableViewTemplate
//
//  Created by Jake on 6/2/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//
// Custome TableViewCell to remember the titleLabel, subtitleLabel, and imageButton.

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func changeTextColor (color: UIColor) {
        titleLabel.textColor = color
        subtitleLabel.textColor = color
    }
}

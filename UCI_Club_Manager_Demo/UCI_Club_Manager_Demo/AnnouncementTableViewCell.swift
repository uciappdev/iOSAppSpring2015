//
//  AnnouncementTableViewCell.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/6/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class AnnouncementTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var paragraph: UILabel!
    
    
    @IBOutlet weak var time_stamp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        paragraph.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

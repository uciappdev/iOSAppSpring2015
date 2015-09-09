//
//  About.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/5/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class About {
    var id: String
    var time_stamp: String
    var club_id: String
    var paragraph: String
    var center_photo_url: String
    
    init(id: String, time_stamp: String, club_id: String, paragraph: String, center_photo_url: String) {
        self.id = id
        self.time_stamp = time_stamp
        self.club_id = club_id
        self.paragraph = paragraph
        self.center_photo_url = center_photo_url
    }
}
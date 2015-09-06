//
//  Announcements.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/5/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class Announcement {
    var id: Int
    var time_stamp: String
    var club_id: String
    var title: String
    var subtitle: String
    var paragraph: String
    
    init(id: Int, time_stamp: String, club_id: String, title: String, subtitle: String, paragraph: String) {
        self.id = id
        self.time_stamp = time_stamp
        self.club_id = club_id
        self.title = title
        self.subtitle = subtitle
        self.paragraph = paragraph
    }
}
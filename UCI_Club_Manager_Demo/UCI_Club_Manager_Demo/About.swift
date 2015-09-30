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
    var email: String
    var website: String
    var far_left_photo_url: String
    var left_photo_url: String
    var center_photo_url: String
    var right_photo_url: String
    var far_right_photo_url: String
    
    init(id: String, time_stamp: String, club_id: String, paragraph: String, email: String, website: String, far_left_photo_url: String, left_photo_url: String, center_photo_url: String, right_photo_url: String, far_right_photo_url: String) {
        self.id = id
        self.time_stamp = time_stamp
        self.club_id = club_id
        self.paragraph = paragraph
        self.email = email
        self.website = website
        self.far_left_photo_url = far_left_photo_url
        self.left_photo_url = left_photo_url
        self.center_photo_url = center_photo_url
        self.right_photo_url = right_photo_url
        self.far_right_photo_url = far_right_photo_url
    }
}
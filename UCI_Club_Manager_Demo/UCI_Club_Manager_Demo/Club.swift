//
//  Club.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 8/25/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class Club {
    var id: String
    var time_stamp: String
    var name: String
    var category: String
    var date_started: String
    
    init(id: String, time_stamp: String, name: String, category: String, date_started: String) {
        self.id = id
        self.time_stamp = time_stamp
        self.name = name
        self.category = category
        self.date_started = date_started
    }
}



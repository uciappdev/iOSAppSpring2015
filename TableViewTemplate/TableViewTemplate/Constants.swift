//
//  Constants.swift
//  TableViewTemplate
//
//  Created by Jake on 8/18/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

let defaults = NSUserDefaults.standardUserDefaults()

var theme : String? {
    return defaults.stringForKey(keys[0])
}
var icon : String? {
    return defaults.stringForKey(keys[1])
}

let circledImageFileName = "marker-circle.png"

struct themeData {
    static let fileNames = ["beach.jpg","night-sky.jpg"]
}

struct iconData {
    static let fileNames = ["redCameraIcon.png","yellowCameraIcon.png"]
}


let keys = ["themeKey", "iconKey"]

let optionsList = ["Themes", "Icons"]
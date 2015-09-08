//
//  Service.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 8/25/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class Service {
    var settings:Settings!
    
    init(){
        self.settings = Settings()
    }
    
    func pull_about(clubId: String, callback: (NSArray) -> ()) {
        request("\(settings.getAboutTable)?club_id=\(clubId)", callback: callback)
    }
    
    func pull_announcements(clubId: String, callback: (NSArray) -> ()) {
        request("\(settings.getAnnouncementTable)?club_id=\(clubId)", callback: callback)
    }
    
    func pull_questions(clubId: String, callback: (NSArray) -> ()) {
        request("\(settings.getQuestionTable)?club_id=\(clubId)", callback: callback)
    }
    
    func pull_club(callback: (NSArray) -> ()) {
        request(settings.getClubTable, callback: callback)
    }
    
    func request(url:String, callback: (NSArray -> ())) {
        let nsURL = NSURL(string: url)!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL) {
            (data, response, error) in
            
            var error:NSError?
            if let response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? NSArray {
                callback(response)
            }

            
        }
        task.resume()
    }
}
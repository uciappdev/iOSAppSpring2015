//
//  GetClubsService.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 8/25/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class ClubService {
    var settings:Settings!
    
    init(){
        self.settings = Settings()
    }
    
    func getClubs(callback: (NSArray) -> ()) {
        request(settings.getClubTable, callback: callback)
    }
    
    func request(url:String, callback: (NSArray -> ())) {
        let nsURL = NSURL(string: url)!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL) {
            (data, response, error) in
            
            var error:NSError?
            var response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
            callback(response)
        }
        task.resume()
    }
}
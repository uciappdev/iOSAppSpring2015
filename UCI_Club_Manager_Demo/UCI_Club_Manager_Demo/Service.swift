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
    
    func increment_vote(questionId: String, voteNum: Int) {
        let url = "\(settings.incrementVoteCount)?question_id=\(questionId)&answer_vote_num=\(voteNum+1)"
        requestUpdate(url)
    }
    
    func pull_about(clubId: String, callback: (NSArray) -> ()) {
        requestPull("\(settings.getAboutTable)?club_id=\(clubId)", callback: callback)
    }
    
    func pull_announcements(clubId: String, callback: (NSArray) -> ()) {
        requestPull("\(settings.getAnnouncementTable)?club_id=\(clubId)", callback: callback)
    }
    
    func pull_questions(clubId: String, callback: (NSArray) -> ()) {
        requestPull("\(settings.getQuestionTable)?club_id=\(clubId)", callback: callback)
    }
    
    func pull_club(callback: (NSArray) -> ()) {
        requestPull(settings.getClubTable, callback: callback)
    }
    
    func pull_vote_count(questionId: String, callback: (NSArray) -> ()) {
        requestPull("\(settings.getVoteCount)?question_id=\(questionId)", callback: callback)
    }
    
    func requestPull(url:String, callback: (NSArray -> ()), pull:Bool = true) {
        let nsURL = NSURL(string: url)!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL) {
            (data, response, error) in
            
            var error:NSError?
            if pull {
                if let response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? NSArray {
                    callback(response)
                }
            }
        }
        task.resume()
    }
    
    func requestUpdate(url: String) {
        let nsURL = NSURL(string: url)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL) {
            (data, response, error) -> Void in
            var error:NSError?
        }
        task.resume()
    }
}
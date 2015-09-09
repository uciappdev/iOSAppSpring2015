//
//  Questions.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/7/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class Question {
    var id: String
    var time_stamp: String
    var club_id: String
    var question: String
    var answer_1: String
    var answer_2: String
    var answer_3: String
    var answer_4: String
    var answer_5: String
    var answer_1_votes: String
    var answer_2_votes: String
    var answer_3_votes: String
    var answer_4_votes: String
    var answer_5_votes: String
    
    init(id: String, time_stamp: String, club_id: String, question: String,
        answer_1: String, answer_2: String, answer_3: String, answer_4: String, answer_5: String,
        answer_1_votes: String, answer_2_votes: String, answer_3_votes: String, answer_4_votes: String, answer_5_votes: String) {
        self.id = id
        self.time_stamp = time_stamp
        self.club_id = club_id
        self.question = question
        self.answer_1 = answer_1
        self.answer_2 = answer_2
        self.answer_3 = answer_3
        self.answer_4 = answer_4
        self.answer_5 = answer_5
        self.answer_1_votes = answer_1_votes
        self.answer_2_votes = answer_2_votes
        self.answer_3_votes = answer_3_votes
        self.answer_4_votes = answer_4_votes
        self.answer_5_votes = answer_5_votes
    }
}
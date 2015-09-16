//
//  VoteCount.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/8/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class VoteCount {

    var answer_1_votes: Double
    var answer_2_votes: Double
    var answer_3_votes: Double
    var answer_4_votes: Double
    var answer_5_votes: Double
    var vote_list: [Double]
    var total_votes: Double
    
    init(answer_1_votes: Double, answer_2_votes: Double, answer_3_votes: Double, answer_4_votes: Double, answer_5_votes: Double, vote_list: [Double], total_votes: Double) {

        self.answer_1_votes = answer_1_votes
        self.answer_2_votes = answer_2_votes
        self.answer_3_votes = answer_3_votes
        self.answer_4_votes = answer_4_votes
        self.answer_5_votes = answer_5_votes
        self.vote_list = vote_list
        self.total_votes = total_votes
    }
}
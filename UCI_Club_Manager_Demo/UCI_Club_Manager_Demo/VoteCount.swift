//
//  VoteCount.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/8/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class VoteCount {

    var answer_1_votes: Int
    var answer_2_votes: Int
    var answer_3_votes: Int
    var answer_4_votes: Int
    var answer_5_votes: Int
    var vote_list: [Int]
    var total_votes: Int
    
    init(answer_1_votes: Int, answer_2_votes: Int, answer_3_votes: Int, answer_4_votes: Int, answer_5_votes: Int, vote_list: [Int], total_votes: Int) {

        self.answer_1_votes = answer_1_votes
        self.answer_2_votes = answer_2_votes
        self.answer_3_votes = answer_3_votes
        self.answer_4_votes = answer_4_votes
        self.answer_5_votes = answer_5_votes
        self.vote_list = vote_list
        self.total_votes = total_votes
    }
}
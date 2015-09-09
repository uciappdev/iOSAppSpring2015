//
//  AnswerViewController.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/5/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var question: Question?
    var answerList = [String]()
    
    var voteCount: VoteCount?
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerPickerView: UIPickerView!
    @IBOutlet weak var pollResultLabel: UILabel!
    
    @IBAction func submitButton(sender: UIButton) {
        //push to database and reveal the current results.

        sender.enabled = false
        var service = Service()
        service.increment_vote(question!.id, voteNum: answerPickerView.selectedRowInComponent(0))
        loadGraph()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let voteCount = voteCount {
            pollResultLabel.text = "\(voteCount.vote_list)"
            pollResultLabel.hidden = false
        }
        else {
            questionLabel.text = question!.question
            pollResultLabel.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return answerList.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return answerList[row]
    }
    
    func loadGraph() {
        var service = Service()
        service.pull_vote_count(question!.id) {
            (response) in
            self.loadVoteCount(response)
        }
        
    }
    
    func loadVoteCount(votes : NSArray) {
        // Create announcement objects and reload the table.
        
        var answer_1_votes = (votes[0]["answer_1_votes"]! as! String).toInt()!
        var answer_2_votes = (votes[0]["answer_2_votes"]! as! String).toInt()!
        var answer_3_votes = (votes[0]["answer_3_votes"]! as! String).toInt()!
        var answer_4_votes = (votes[0]["answer_4_votes"]! as! String).toInt()!
        var answer_5_votes = (votes[0]["answer_5_votes"]! as! String).toInt()!
        var vote_list = [answer_1_votes, answer_2_votes, answer_3_votes, answer_4_votes, answer_5_votes]
        var total_votes = vote_list.reduce(0, combine: +)
        
        var clubObj = VoteCount(answer_1_votes: answer_1_votes, answer_2_votes: answer_2_votes, answer_3_votes:answer_3_votes, answer_4_votes: answer_4_votes, answer_5_votes: answer_5_votes, vote_list: vote_list, total_votes: total_votes)
        
        voteCount = clubObj
        dispatch_async(dispatch_get_main_queue()) {
            self.viewDidLoad()
        }
    }



}

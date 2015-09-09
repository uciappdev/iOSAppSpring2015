//
//  QuestionTableViewController.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/5/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class QuestionTableViewController: UITableViewController {

    let cellHeight : CGFloat = 70.0
    var clubQuestions = [Question]()
    var selectedQuestion: Question?
    override func viewDidLoad() {
        super.viewDidLoad()

        if clubQuestions.count == 0 {
            let tbc = self.tabBarController as! ClubTabBarController
            
            var service = Service()
            service.pull_questions("\(tbc.club!.id)") {
                (response) in
                self.loadQuestions(response)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if clubQuestions.count == 0 {
            return 0
        }
        return clubQuestions.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestionCell", forIndexPath: indexPath) as! QuestionTableViewCell
        cell.time_stamp.text = clubQuestions[indexPath.row].time_stamp
        cell.question.text = clubQuestions[indexPath.row].question
        

        return cell
    }

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedQuestion = clubQuestions[indexPath.row]
        return indexPath
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let avc = segue.destinationViewController as? AnswerViewController {
            avc.question = selectedQuestion!
            var ansList = [selectedQuestion!.answer_1, selectedQuestion!.answer_2, selectedQuestion!.answer_3, selectedQuestion!.answer_4, selectedQuestion!.answer_5]
            avc.answerList = ansList
        }
    }

    
    
    func loadQuestions(questions : NSArray) {
        // Create announcement objects and reload the table.
        for question in questions{
            var id = question["id"]! as! String
            var time_stamp = question["time_stamp"]! as! String
            var club_id = question["club_id"]! as! String
            var q = question["question"]! as! String
            var answer_1 = question["answer_1"]! as! String
            var answer_2 = question["answer_2"]! as! String
            var answer_3 = question["answer_3"]! as! String
            var answer_4 = question["answer_4"]! as! String
            var answer_5 = question["answer_5"]! as! String
            var answer_1_votes = question["answer_1_votes"]! as! String
            var answer_2_votes = question["answer_2_votes"]! as! String
            var answer_3_votes = question["answer_3_votes"]! as! String
            var answer_4_votes = question["answer_4_votes"]! as! String
            var answer_5_votes = question["answer_5_votes"]! as! String
            
            var clubObj = Question(id: id, time_stamp: time_stamp, club_id: club_id,question: q, answer_1: answer_1, answer_2: answer_2, answer_3: answer_3, answer_4: answer_4, answer_5: answer_5, answer_1_votes: answer_1_votes, answer_2_votes: answer_2_votes, answer_3_votes:answer_3_votes, answer_4_votes: answer_4_votes, answer_5_votes: answer_5_votes)
            clubQuestions.append(clubObj)
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }

}

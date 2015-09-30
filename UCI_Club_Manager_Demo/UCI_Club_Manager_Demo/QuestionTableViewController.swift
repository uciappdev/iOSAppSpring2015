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
            
            let service = Service()
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
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Virtually removes the unused tableview cells
        return 0.01
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let avc = segue.destinationViewController as? AnswerViewController {
            avc.question = selectedQuestion!
            let ansList = [selectedQuestion!.answer_1, selectedQuestion!.answer_2, selectedQuestion!.answer_3, selectedQuestion!.answer_4, selectedQuestion!.answer_5]
            avc.answerList = ansList
        }
    }

    
    
    func loadQuestions(questions : NSArray) {
        // Create announcement objects and reload the table.
        for question in questions{
            let id = question["id"]! as! String
            let time_stamp = question["time_stamp"]! as! String
            let club_id = question["club_id"]! as! String
            let q = question["question"]! as! String
            let answer_1 = question["answer_1"]! as! String
            let answer_2 = question["answer_2"]! as! String
            let answer_3 = question["answer_3"]! as! String
            let answer_4 = question["answer_4"]! as! String
            let answer_5 = question["answer_5"]! as! String
            let answer_1_votes = question["answer_1_votes"]! as! String
            let answer_2_votes = question["answer_2_votes"]! as! String
            let answer_3_votes = question["answer_3_votes"]! as! String
            let answer_4_votes = question["answer_4_votes"]! as! String
            let answer_5_votes = question["answer_5_votes"]! as! String
            
            let clubObj = Question(id: id, time_stamp: time_stamp, club_id: club_id,question: q, answer_1: answer_1, answer_2: answer_2, answer_3: answer_3, answer_4: answer_4, answer_5: answer_5, answer_1_votes: answer_1_votes, answer_2_votes: answer_2_votes, answer_3_votes:answer_3_votes, answer_4_votes: answer_4_votes, answer_5_votes: answer_5_votes)
            clubQuestions.append(clubObj)
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }

}

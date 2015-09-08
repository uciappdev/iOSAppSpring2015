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
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var pollResultLabel: UILabel!
    @IBAction func submitButton(sender: UIButton) {
        //push to database and reveal the current results.
        pollResultLabel.text = "\(question!.answer_1): \(question!.answer_1_votes) \n" +
            "\(question!.answer_2): \(question!.answer_2_votes) \n" +
            "\(question!.answer_3): \(question!.answer_3_votes) \n" +
            "\(question!.answer_4): \(question!.answer_4_votes) \n" +
            "\(question!.answer_5): \(question!.answer_5_votes)"
        pollResultLabel.hidden = false
        sender.enabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = question!.question
        pollResultLabel.hidden = true
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


}

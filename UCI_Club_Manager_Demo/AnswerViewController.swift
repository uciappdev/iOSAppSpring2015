//
//  AnswerViewController.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/5/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit
import Charts
class AnswerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var question: Question?
    var answerList = [String]()
    var voteCount: VoteCount?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerPickerView: UIPickerView!
    @IBOutlet weak var barChartView: BarChartView!
    
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
            barChartView.descriptionText = "Poll Results"
            barChartView.xAxis.labelPosition = .Bottom
            barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
            barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
            setChart(answerList, values: voteCount.vote_list)
        }
        else {
            questionLabel.text = question!.question
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
        
        var answer_1_votes = (votes[0]["answer_1_votes"] as! NSString).doubleValue
        var answer_2_votes = (votes[0]["answer_2_votes"]! as! NSString).doubleValue
        var answer_3_votes = (votes[0]["answer_3_votes"]! as! NSString).doubleValue
        var answer_4_votes = (votes[0]["answer_4_votes"]! as! NSString).doubleValue
        var answer_5_votes = (votes[0]["answer_5_votes"]! as! NSString).doubleValue
        var vote_list = [answer_1_votes, answer_2_votes, answer_3_votes, answer_4_votes, answer_5_votes]
        var total_votes = vote_list.reduce(0, combine: +)
        
        var clubObj = VoteCount(answer_1_votes: answer_1_votes, answer_2_votes: answer_2_votes, answer_3_votes:answer_3_votes, answer_4_votes: answer_4_votes, answer_5_votes: answer_5_votes, vote_list: vote_list, total_votes: total_votes)
        
        voteCount = clubObj
        
        dispatch_async(dispatch_get_main_queue()) {
            self.viewDidLoad()
        }
    }

    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Votes")
        chartDataSet.colors = ChartColorTemplates.joyful()
        let chartData = BarChartData(xVals: answerList, dataSet: chartDataSet)
        barChartView.data = chartData
    }


}

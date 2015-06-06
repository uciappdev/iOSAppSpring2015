import UIKit

class QuestionViewViewController: UIViewController, UITableViewDelegate {

    // To determine check marks on the selected cell.
    var selectedRow : Int = 0
    
    // Hard coded values that should be pulled from the database.
    var question : String = ""
    var answers : [String] = []
    
    // Remembers the last selected cell, initialized to personal nil value.
    var lastSelectedCellIndex : Int = -1

    // Button outlets that toggle when pressed.
    @IBOutlet weak var resultsButton: UIBarButtonItem!
    @IBOutlet weak var submitButton: UIButton!
    
    // Allows the results page to be viewed when answer submitted.
    @IBAction func onSubmit(sender: AnyObject) {
        if let Results = self.navigationItem.rightBarButtonItem {
            Results.enabled = true
        }
        //self.navigationItem.rightBarButtonItem!.enabled = true
        submitButton.enabled = false
    }
    
    // Question displayed at the top and the table of possible answers.
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let Results = self.navigationItem.rightBarButtonItem {
            Results.enabled = false
        }
        // On load, display the current question.
        questionLabel.text = question
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // Uncheck if the selected cell currently has a check.
        // Else uncheck the last selected cell and check the new one and making sure to update the location to the last selected cell.
        if (tableView.cellForRowAtIndexPath(indexPath)?.accessoryType == UITableViewCellAccessoryType.Checkmark){
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
        }
        else{
            if (lastSelectedCellIndex != -1){
                // Taking advantage of the fact that there is only one section!
                let lastSelectedIndexPath : NSIndexPath = NSIndexPath(forRow: lastSelectedCellIndex, inSection: 0)
                tableView.cellForRowAtIndexPath(lastSelectedIndexPath)?.accessoryType = UITableViewCellAccessoryType.None
            }
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        lastSelectedCellIndex = indexPath.row
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = self.answerTable.dequeueReusableCellWithIdentifier("answerCell") as! UITableViewCell
        cell.textLabel?.text = self.answers[indexPath.row]
        return cell
    }
    
    // When changing view, if going to the ResultsViewController then pass the current question and answers.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var selectedRowIndex = self.answerTable.indexPathForSelectedRow()
        if let vc : ResultsViewController = segue.destinationViewController as? ResultsViewController {
            vc.question = question
            vc.answers = answers
            UIDevice.currentDevice().setValue(UIDeviceOrientation.Portrait.rawValue, forKey: "orientation")
        }
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    
}

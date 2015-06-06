import UIKit

class QuestionsTableViewController: UIViewController, UITableViewDelegate {
    // CONSTANTS THAT WILL BE REPLACED WITH DATABASE!
    var QUESTIONS : [String] = ["Which do you prefer?", "Beach this Saturday?"]
    var ANSWERS: [[String]] = [["Coke", "Pepsi", "Sprite"], ["Yes", "No", "Maybe", "Hell Yeah!"]]
    
    @IBOutlet weak var TableQuestions: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Return the number of cells in the table (with a single section).
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QUESTIONS.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell : UITableViewCell = self.TableQuestions.dequeueReusableCellWithIdentifier("questionCell") as! UITableViewCell
        cell.textLabel?.text = self.QUESTIONS[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }

    // Only possible segue is for the single question view, pass then selected question and its answers.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var selectedRowIndex = self.TableQuestions.indexPathForSelectedRow()
        self.TableQuestions.deselectRowAtIndexPath(selectedRowIndex!, animated: true)
        var vc : QuestionViewViewController = segue.destinationViewController as! QuestionViewViewController
        vc.question = QUESTIONS[selectedRowIndex!.row]
        vc.answers = ANSWERS[selectedRowIndex!.row]
    }
}

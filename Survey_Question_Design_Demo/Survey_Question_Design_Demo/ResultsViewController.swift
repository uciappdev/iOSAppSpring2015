import UIKit

class ResultsViewController: UIViewController {
    // -----Variable declarations.-----
    // Initialize the pie chart as a Layer.
    let pieLayer = PieLayer()
    
    // Initialize the tap gesture and set the last tapped element index to be "null."
    let tapRec = UITapGestureRecognizer()
    var lastTappedElemIndex : Int = -1
    
    // List the available title options for the pie chart and initialize it's index to 0.
    var titleOptions = ["Percentage", "Vote Count", "Answer"]
    var titleOptionIndex = 0
    
    // Hard coded values that should be pulled from the database.
    var question : String = ""
    var answers : [String] = []
    var answerValues : [Float] = [0.1,0.2,0.3,0.4,0.5]
    var answerVotes : [Int] = [5,10,15,20,25]
    
    // View labels that are updated.
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var selectedElemTitle: UILabel!
    
    // Handles when the pie chart title button is pressed.
    @IBOutlet weak var titlesButton: UIButton!
    // Advances the title option index with the choices from the titleOptions array. Displays the appropriate title option on the pie chart.
    @IBAction func changeTitles(sender: AnyObject) {
        titleOptionIndex = incrementTitleIndex(titleOptionIndex)
        var nextTitleIndex = incrementTitleIndex(titleOptionIndex)
        var currentTitle = titleOptions[titleOptionIndex]
        let nextTitle = titleOptions[nextTitleIndex]

        switch currentTitle {
        case "Percentage":
            pieLayer.transformTitleBlock = {(elem,percent) -> String! in
                let percentage : Int = Int(elem.val * 100)
                return "\(percentage)%"
            }
        case "Vote Count":
            pieLayer.transformTitleBlock = {(elem,percent) -> String! in
                // This gets rid of the Optional
                let voteCount : Int! = elem.voteCount
                return "\(voteCount) Votes"
            }
        default: //"titles"
            pieLayer.transformTitleBlock = {(elem,percent) -> String! in
                // This gets rid of the Optional
                let title : String! = elem.title
                return "\(title)"
            }
        }
        titlesButton.setTitle(nextTitle, forState: UIControlState.Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color.
        view.backgroundColor = UIColor.blackColor()
        //view.backgroundColor = UIColor(red: 200, green: 200, blue: 200)
        
        // Initialize labels at view.
        questionLabel.text = question
        let initialTitleLabel = titleOptions[titleOptionIndex+1]
        titlesButton.setTitle(initialTitleLabel, forState: UIControlState.Normal)
        
        // Initialize single tap recognition.
        tapRec.addTarget(self, action: Selector("tappedView:"))
        view.userInteractionEnabled = true
        view.addGestureRecognizer(tapRec)
        
        // Initialize pie chart settings on view load.
        pieLayer.showTitles = ShowTitlesAlways
        addAllValues(pieLayer)
        pieLayer.transformTitleBlock = {(elem,percent) -> String! in
            let percentage : Int = Int(elem.val * 100)
            return "\(percentage)%"
        }
        view.layer.addSublayer(pieLayer)
        // If the incoming segue is landscape, the width and heights will be switched for the frame.
        setFrameWidthAndHeight()
        // How long the pie chart animation is in seconds.
        pieLayer.animationDuration = 2
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Returns a random color.
    func getRandomColor() -> UIColor{
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    // Set frame dimensions to always fit portrait well.
    func setFrameWidthAndHeight(){
        var width : CGFloat
        var height : CGFloat
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            //println("landscape")
            height = UIScreen.mainScreen().bounds.width
            width = UIScreen.mainScreen().bounds.height
        } else {
            //println("portraight")
            width = UIScreen.mainScreen().bounds.width
            height = UIScreen.mainScreen().bounds.height
        }
        self.pieLayer.frame = CGRectMake(0, 0, width, height)
    }
    
    // Add all values to the pie chart.
    func addAllValues(pLayer : PieLayer){
        for var index = 0; index < answers.count; ++index{
            var elem : PieElement = PieElement(value: answerValues[index], color: getRandomColor())
            elem.title = answers[index]
            elem.voteCount = answerVotes[index]
            pieLayer.addValues([elem], animated: true)
        }
    }
    
    // Remove all values from pie chart.
    func deleteAllValues(player : PieLayer){
        for pieElem : PieElement in player.values as! [PieElement]{
            player.deleteValues([pieElem], animated: false)
        }
    }
    
    // Returns the correct title display and wraps if the index is out of range.
    func incrementTitleIndex (var index : Int) -> Int{
        ++index
        if index >= titleOptions.count {
            index = 0
        }
        return index
    }
    
    // Does not allow the option for landscape when the phone is turned.
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    // Only allows the portrait views.
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }

    
    // Before pressing the back button, pass the question and answer variables back to the QuestionView.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var vc : QuestionViewViewController = segue.destinationViewController as! QuestionViewViewController
        vc.question = question
        vc.answers = answers
    }
    
    // When the view is tapped, if the tap coordinate is in a pie element toggle it's offset.
    // NOTE: had problems setting the lastElem.centrOffset to be 0... not sure why.  Had to code a rather ugly work around using the -= operator.  This should be fixed to reduce complexity but it works.
    func tappedView(tap : UITapGestureRecognizer){
        let pos : CGPoint = tap.locationInView(self.view)
        println("\(pos)")
        // If the tap coordinate was in the pie chart... find which one
        if let tappedElem : PieElement = self.pieLayer.pieElemInPoint(pos) {
            let tappedElemIndex : Int = find(self.pieLayer.values as! [PieElement], tappedElem) as Int!
            if lastTappedElemIndex != -1{ // If not the first tap...
                let lastElem : PieElement = pieLayer.values[lastTappedElemIndex] as! PieElement
                if lastTappedElemIndex == tappedElemIndex {
                    lastElem.centrOffset = (lastElem.centrOffset.isZero ? 20 : 0)
                }
                else {
                    lastElem.centrOffset = 0
                    tappedElem.centrOffset = 20
                }
            }
            else {
                tappedElem.centrOffset = 20
            }
            selectedElemTitle.text = tappedElem.title
            lastTappedElemIndex = tappedElemIndex as Int
        }
    }
}


// EXTENSIONS
// Extension made so the PieElements will remember their string title and int vote count.
private var titleAssociationKey: UInt8 = 0
private var voteCountAssociationKey: UInt8 = 0
extension PieElement {
    var title: String?{
        get{
            
            return objc_getAssociatedObject(self, &titleAssociationKey) as? String
        }
        set{
            objc_setAssociatedObject(self, &titleAssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        }
    }
    var voteCount : Int?{
        get{
            return objc_getAssociatedObject(self, &voteCountAssociationKey) as? Int
        }
        set{
            objc_setAssociatedObject(self, &voteCountAssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        }
    }
}

// Used this extension to easily create Colors.
extension UIColor{
    convenience init(red: Int, green: Int, blue: Int){
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

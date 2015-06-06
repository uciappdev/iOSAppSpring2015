//
//  ViewController.swift
//  TableViewTemplate
//
//  Created by Jake on 6/2/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    // StoryBoard objects.
    @IBOutlet weak var myTableView: UITableView!
    @IBAction func imageButtonAction (sender : UIButton!) {
        performSegueWithIdentifier("showImage", sender: sender)
    }
    
    // Input Data
    var titleData : [String] = ["Earth", "Mars", "Pluto"]
    var subtitleData : [String] = ["Blue planet", "Red planet", "Planet?"]
    var imageFileNames : [String] = ["earth.jpg", "mars.jpg", "pluto.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // TableView Functions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.myTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
        if let button = cell.imageButton {
            button.tag = indexPath.row
            button.setImage(UIImage(named: "camera-icon1.jpg"),forState: UIControlState.Normal)
            //button.setImage(UIImage(named: imageFileNames[indexPath.row]),forState: UIControlState.Normal)
            button.addTarget(self, action: "imageButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        cell.titleLabel.text = titleData[indexPath.row]
        cell.subtitleLabel.text = subtitleData[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // ADD CODE HERE TO DO SOMETHING WHEN TABLEVIEWCELL TAPPED
    }
    
    // Segue Functions
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Pass the selected image file name to the next view.
        let tag = sender!.tag
        let vc : SecondViewController = segue.destinationViewController as! SecondViewController
        vc.imageFileName = imageFileNames[tag]
    }
}


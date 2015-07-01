//
//  ViewController.swift
//  TableViewTemplate
//
//  Created by Jake on 6/2/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    //Constants
    let isBeachThemeKey = "isBeachThemeKey"
    let isRedCameraKey = "isRedCameraKey"
    let redCameraImageFileName = "redCameraIcon.png"
    let yellowCammeraImageFileName = "yellowCameraIcon.png"
    let beachImageFileName = "beach.jpg"
    let spaceImageFileName = "night-sky.jpg"
    // Placeholder boolean
    var isBeachTheme = false
    var isRedCameraIcon = false

    // StoryBoard objects.
    @IBOutlet weak var myTableView: UITableView!
    @IBAction func imageButtonAction (sender : UIButton!) {
        performSegueWithIdentifier("showImage", sender: sender)
    }
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    // Input data that should be gotten from Database
    var titleData = ["Earth", "Mars", "Pluto"]
    var subtitleData = ["Blue planet", "Red planet", "Planet?"]
    var imageFileNames = ["earth.jpg", "mars.jpg", "pluto.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.backgroundColor = UIColor.clearColor()
    }
    override func viewWillAppear(animated: Bool) {
        // Load Theme and change UITableView colors
        isBeachTheme = NSUserDefaults.standardUserDefaults().boolForKey(isBeachThemeKey)
        isRedCameraIcon = NSUserDefaults.standardUserDefaults().boolForKey(isRedCameraKey)
        isBeachTheme ? loadTheme(beachImageFileName, color: UIColor.blackColor()) : loadTheme(spaceImageFileName, color: UIColor.whiteColor())
        myTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // UITableView methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.myTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
        if let button = cell.imageButton {
            button.tag = indexPath.row
            //isRedCameraIcon ?
            isRedCameraIcon ? button.setImage(UIImage(named: redCameraImageFileName),forState: UIControlState.Normal) : button.setImage(UIImage(named: yellowCammeraImageFileName),forState: UIControlState.Normal)
            //button.setImage(UIImage(named: imageFileNames[indexPath.row]),forState: UIControlState.Normal)
            button.addTarget(self, action: "imageButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        cell.titleLabel.text = titleData[indexPath.row]
        cell.subtitleLabel.text = subtitleData[indexPath.row]
        isBeachTheme ? cell.changeTextColor(UIColor.blackColor()) : cell.changeTextColor(UIColor.whiteColor())
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Virtually removes the unused tableview cells
        return 0.01
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // ADD CODE HERE TO DO SOMETHING WHEN TABLEVIEWCELL TAPPED
    }
    
    // Segue Functions
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Pass the selected image file name to the next view.
        if let vc = segue.destinationViewController as? ImageViewController {
            let tag = sender!.tag
            vc.imageFileName = imageFileNames[tag]
        }
    }
    
    // Helper functions
    func loadTheme(imageFileName: String, color: UIColor) {
        backgroundImage.image = UIImage(named: imageFileName)
        myTableView.separatorColor = color
    }
}


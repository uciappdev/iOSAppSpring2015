//
//  PlanetaryViewController.swift
//  TableViewTemplate
//
//  Created by Jake on 6/2/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit


class PlanetaryViewController: UIViewController, UITableViewDelegate {
    
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
        if let currentTheme = theme {
            loadTheme(currentTheme)
        }
        else {
            defaults.setObject(themeData.fileNames[0], forKey: keys[0])
            loadTheme(theme!)
        }
        if icon == nil {
            defaults.setObject(iconData.fileNames[0], forKey: keys[1])
        }
        defaults.synchronize()
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
        let cell = self.myTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PlanetaryCustomTableViewCell
        if let button = cell.imageButton {
            button.tag = indexPath.row
            if let currentIcon = icon {
                button.setImage(UIImage(named: currentIcon), forState: UIControlState.Normal)
            }

            button.addTarget(self, action: "imageButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        cell.titleLabel.text = titleData[indexPath.row]
        cell.subtitleLabel.text = subtitleData[indexPath.row]
        
        if let currentTheme = theme {
            let color = colorBasedOnTheme(currentTheme)
            cell.changeTextColor(color)
        }
        
        
        
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Virtually removes the unused tableview cells
        return 0.01
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
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
    func colorBasedOnTheme(theme: String) -> UIColor {
        switch theme {
        case themeData.fileNames[0]: // Beach Theme
            return UIColor.blackColor()
        case themeData.fileNames[1]: // Space Theme
            return UIColor.whiteColor()
        default: // This should be changed to a different color
            return UIColor.redColor()
        }
    }
    
    func loadTheme(imageFileName: String) {
        backgroundImage.image = UIImage(named: imageFileName)
        
        myTableView.separatorColor = colorBasedOnTheme(imageFileName)
    }

}


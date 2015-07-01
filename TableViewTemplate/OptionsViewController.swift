//
//  OptionsViewController.swift
//  TableViewTemplate
//
//  Created by Jake on 6/22/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    // Constants
    let isRedCameraKey = "isRedCameraKey"
    let isBeachThemeKey = "isBeachThemeKey"
    let beachImageFileName = "beach.jpg"
    let spaceImageFileName = "night-sky.jpg"
    let circledImage = UIImage(named: "marker-circle.png")
    let redCameraIconTitle = "Red Camera"
    let beachThemeTitle = "Beach"
    var defaults = NSUserDefaults.standardUserDefaults()
    
    // Storyboard Objects
    @IBOutlet weak var cameraIconLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    
    @IBOutlet weak var circledRedCameraImage: UIImageView!
    @IBOutlet weak var circledYellowCameraImage: UIImageView!
    
    @IBOutlet weak var circledBeachTheme: UIButton!
    @IBOutlet weak var circledSpaceTheme: UIButton!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBAction func cameraIconSelected(sender: UIButton) {
        if let cameraIcon = sender.titleLabel?.text {
            let isRedCamera = cameraIcon == redCameraIconTitle
            circleCameraIcon(isRedCamera)
        }
    }

    @IBAction func themeSelected(sender: UIButton) {
        if let theme = sender.titleLabel?.text {
            let isBeachTheme = theme == beachThemeTitle
            isBeachTheme ? circleTheme(true, theme: beachImageFileName, color: UIColor.blackColor()) : circleTheme(false, theme: spaceImageFileName, color: UIColor.whiteColor())
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let isRedCamera = defaults.boolForKey(isRedCameraKey)
        circleCameraIcon(isRedCamera)
        let isBeachTheme = defaults.boolForKey(isBeachThemeKey)
        isBeachTheme ? circleTheme(true, theme: beachImageFileName, color: UIColor.blackColor()) : circleTheme(false, theme: spaceImageFileName, color: UIColor.whiteColor())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func circleCameraIcon(isRedCamera: Bool) {
        // Hide the corresponsing image with relation to which camera icon was last selected.  Also remember it in NSUserDefaults.
        circledRedCameraImage.hidden = !isRedCamera
        circledYellowCameraImage.hidden = isRedCamera
        defaults.setBool(isRedCamera, forKey: isRedCameraKey)
    }
    
    
    func circleTheme(isBeachTheme: Bool, theme: String, color: UIColor) {
        // Change all settings to match to selected theme and remember it in NSUserDefaults.
        isBeachTheme ? circledBeachTheme.setBackgroundImage(circledImage, forState: .Normal) : circledBeachTheme.setBackgroundImage(nil, forState: .Normal)
        isBeachTheme ? circledSpaceTheme.setBackgroundImage(nil, forState: .Normal) : circledSpaceTheme.setBackgroundImage(circledImage, forState: .Normal)
        backgroundImage.image = UIImage(named: theme)
        cameraIconLabel.textColor = color
        themeLabel.textColor = color
        circledSpaceTheme.setTitleColor(color, forState: .Normal)
        circledBeachTheme.setTitleColor(color, forState: .Normal)
        defaults.setBool(isBeachTheme, forKey: isBeachThemeKey)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  AboutUsViewController.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/1/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    //var club = [Club]()
    var clubAbout = [About]()

    
    @IBOutlet weak var aboutParagraph: UILabel!
    @IBOutlet weak var aboutCenterPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if clubAbout.count != 0 {
            aboutParagraph.text = clubAbout[0].paragraph
            if let url = NSURL(string: clubAbout[0].center_photo_url) {
                if let data = NSData(contentsOfURL: url){
                    aboutCenterPhoto.contentMode = UIViewContentMode.ScaleAspectFit
                    aboutCenterPhoto.image = UIImage(data: data)
                }
            }
        }
        else {
            let tbc = self.tabBarController as! ClubTabBarController
            
            println("here")
            
            var service = Service()
            service.pull_about("\(tbc.club[0].id)") {
                (response) in
                self.loadAbout(response)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAbout(clubs : NSArray) {
        
        for club in clubs{
            var id = (club["id"]! as! String).toInt()!
            var time_stamp = club["time_stamp"]! as! String
            var club_id = club["club_id"]! as! String
            var paragraph = club["paragraph"]! as! String
            var center_photo_url = club["center_photo_url"] as! String
            
            var clubObj = About(id: id, time_stamp: time_stamp, club_id: club_id, paragraph: paragraph, center_photo_url: center_photo_url)
            clubAbout.append(clubObj)
            dispatch_async(dispatch_get_main_queue()) {
                self.viewDidLoad()
            }
        }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        println("here")
//        var tabBarController = segue.destinationViewController as! ClubTabBarController;
//        if let vcs = tabBarController.viewControllers {
//            var destinationViewController = vcs[1] as! AnnouncementsTableViewController
//            //destinationViewController.club = club
//            
//            println("passing the club")
//        }
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

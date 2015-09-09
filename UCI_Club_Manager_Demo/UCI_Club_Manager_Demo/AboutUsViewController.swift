//
//  AboutUsViewController.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/1/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    var clubAbout: About?

    
    @IBOutlet weak var aboutParagraph: UILabel!
    @IBOutlet weak var aboutCenterPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let about = clubAbout {
            aboutParagraph.text = clubAbout!.paragraph
            if let url = NSURL(string: clubAbout!.center_photo_url) {
                if let data = NSData(contentsOfURL: url){
                    aboutCenterPhoto.contentMode = UIViewContentMode.ScaleAspectFit
                    aboutCenterPhoto.image = UIImage(data: data)
                }
            }
        }
        else {
            let tbc = self.tabBarController as! ClubTabBarController
            var service = Service()
            service.pull_about("\(tbc.club!.id)") {
                (response) in
                self.loadAbout(response)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadAbout(clubs : NSArray) {
        // There should only be one club
        // Create about object and reload the page.
        var id = clubs[0]["id"]! as! String
        var time_stamp = clubs[0]["time_stamp"]! as! String
        var club_id = clubs[0]["club_id"]! as! String
        var paragraph = clubs[0]["paragraph"]! as! String
        var center_photo_url = clubs[0]["center_photo_url"] as! String
        
        var aboutObj = About(id: id, time_stamp: time_stamp, club_id: club_id, paragraph: paragraph, center_photo_url: center_photo_url)
        clubAbout = aboutObj
        dispatch_async(dispatch_get_main_queue()) {
            self.viewDidLoad()
        }
    }
}

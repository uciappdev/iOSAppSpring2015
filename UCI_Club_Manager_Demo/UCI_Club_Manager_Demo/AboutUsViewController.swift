//
//  AboutUsViewController.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/1/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController, UIScrollViewDelegate {
    var clubAbout: About?
    
    // Storyboard objects
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var paragraph: UILabel!
    @IBOutlet weak var websiteLink: UIButton!
    @IBAction func websiteAction(sender: UIButton) {
        
    }
    @IBOutlet weak var emailLink: UIButton!
    @IBAction func emailAction(sender: UIButton) {
    }
    
    // Activity indicator pop up objects
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Variables
    // Constant that states the number of pages.
    let pageCount = 5
    // Generate a list of image file paths.
    var filePaths = [String]()
    // Pages are loaded and remembered
    var pageViews = [UIImageView?]()
    // Determine whether to roate or not.  Allow roate when viewing the pop up.
    var allowRotate = false
    // Remember the current page selected
    var currentPage: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //println("viewDIdLoad")
        
        currentPage = 0
        
        // Set the number of pages for the page control
        pageControl.numberOfPages = pageCount
        
        // Set up the array to hold the views for each page
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // Call the web service if hadn't already
        if let _ = clubAbout {
        }
        else {
            let tbc = self.tabBarController as! ClubTabBarController
            let service = Service()
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
        print("loadAbout")
        // There should only be one club
        // Create about object and reload the page.
        let id = clubs[0]["id"]! as! String
        let time_stamp = clubs[0]["time_stamp"]! as! String
        let club_id = clubs[0]["club_id"]! as! String
        let paragraph = clubs[0]["paragraph"]! as! String
        let email = clubs[0]["email"]! as! String
        let website = clubs[0]["website"]! as! String
        let far_left_photo_url = clubs[0]["far_left_photo_url"]! as! String
        let left_photo_url = clubs[0]["left_photo_url"]! as! String
        let center_photo_url = clubs[0]["center_photo_url"]! as! String
        let right_photo_url = clubs[0]["right_photo_url"]! as! String
        let far_right_photo_url = clubs[0]["far_right_photo_url"]! as! String
        
        let aboutObj = About(id: id, time_stamp: time_stamp, club_id: club_id, paragraph: paragraph, email: email, website: website, far_left_photo_url: far_left_photo_url, left_photo_url: left_photo_url, center_photo_url: center_photo_url, right_photo_url: right_photo_url, far_right_photo_url: far_right_photo_url)
        filePaths.append(far_left_photo_url)
        filePaths.append(left_photo_url)
        filePaths.append(center_photo_url)
        filePaths.append(right_photo_url)
        filePaths.append(far_right_photo_url)
        clubAbout = aboutObj
        dispatch_async(dispatch_get_main_queue()) {
            self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * CGFloat(self.pageCount), 1.0)
            self.loadImageViews()
            //println("calling loadVisiblePages")
            self.activityIndicator.stopAnimating()
            self.activityView.hidden = true
            self.paragraph.text = self.clubAbout!.paragraph
            self.emailLink.setTitle(self.clubAbout!.email, forState: .Normal)
            self.websiteLink.setTitle(self.clubAbout!.website, forState: .Normal)
            
        }
    }
    
    func loadImageViews () {
        // For each image file path, load the image.
        for (page,file) in filePaths.enumerate() {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            frame = CGRectInset(frame, 10.0, 0.0)
            
            let url = NSURL(string: file)
            let data = NSData(contentsOfURL: url!)
            let newPageView = UIImageView(image: UIImage(data: data!))
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            
            // Enable taps
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
            newPageView.addGestureRecognizer(tapGestureRecognizer)
            newPageView.userInteractionEnabled = true
            
            scrollView.addSubview(newPageView)
            pageViews[page] = newPageView
        }
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // First, determine which page is currently visible
        let pageWidth = scrollView.frame.size.width
        currentPage = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        print("page: \(currentPage)")
        
        // Update the page control
        pageControl.currentPage = currentPage

    }
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
        print("image tapped")
        //let imageView = pageViews[currentPage]!

//        imageView.bounds = view.bounds
//        imageView.transform = CGAffineTransformMakeTranslation(1.3, 1.3)
    }
}

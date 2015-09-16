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
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpImage: UIImageView!
    
    @IBAction func exitPopUp(sender: UIButton) {
        //println("pop up exit")
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        allowRotate = false
        popUpView.hidden = true
    }

    @IBOutlet weak var paragraph: UILabel!
    
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
    // To remember if the the size has already been set.
    var pagesScrollViewSize: CGSize?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //println("viewDIdLoad")
        
        // Set the number of pages for the page control
        pageControl.numberOfPages = pageCount
        
        // Set up the array to hold the views for each page
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // Call the web service if hadn't already
        if let about = clubAbout {
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
    
    override func viewDidLayoutSubviews() {
        //println("viewDidLayoutSubviews")
        // Set up the content size of the scroll view because the viewDidLoad doesn't know about object sizes yet.
        if let pageSize = pagesScrollViewSize {
        }
        else {
            pagesScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSizeMake(pagesScrollViewSize!.width * CGFloat(pageCount), pagesScrollViewSize!.height)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadAbout(clubs : NSArray) {
        println("loadAbout")
        // There should only be one club
        // Create about object and reload the page.
        var id = clubs[0]["id"]! as! String
        var time_stamp = clubs[0]["time_stamp"]! as! String
        var club_id = clubs[0]["club_id"]! as! String
        var paragraph = clubs[0]["paragraph"]! as! String
        var far_left_photo_url = clubs[0]["far_left_photo_url"]! as! String
        var left_photo_url = clubs[0]["left_photo_url"]! as! String
        var center_photo_url = clubs[0]["center_photo_url"]! as! String
        var right_photo_url = clubs[0]["right_photo_url"]! as! String
        var far_right_photo_url = clubs[0]["far_right_photo_url"]! as! String
        
        var aboutObj = About(id: id, time_stamp: time_stamp, club_id: club_id, paragraph: paragraph, far_left_photo_url: far_left_photo_url, left_photo_url: left_photo_url, center_photo_url: center_photo_url, right_photo_url: right_photo_url, far_right_photo_url: far_right_photo_url)
        filePaths.append(far_left_photo_url)
        filePaths.append(left_photo_url)
        filePaths.append(center_photo_url)
        filePaths.append(right_photo_url)
        filePaths.append(far_right_photo_url)
        clubAbout = aboutObj
        dispatch_async(dispatch_get_main_queue()) {
            self.loadImageViews()
            //println("calling loadVisiblePages")
            self.activityIndicator.stopAnimating()
            self.activityView.hidden = true
            self.paragraph.text = self.clubAbout!.paragraph
        }
    }
    
    func loadImageViews () {
        // For each image file path, load the image.
        for (page,file) in enumerate(filePaths) {
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
            var tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
            newPageView.addGestureRecognizer(tapGestureRecognizer)
            newPageView.userInteractionEnabled = true
            
            scrollView.addSubview(newPageView)
            pageViews[page] = newPageView
        }
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //loadVisiblePages()
        // First, determine which page is currently visible
        let pageWidth = scrollView.frame.size.width
        currentPage = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        //println("page: \(currentPage)")
        
        // Update the page control
        pageControl.currentPage = currentPage

    }
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
        //println("image tapped")
        
        popUpImage.image = pageViews[currentPage]!.image
        popUpView.hidden = false
        allowRotate = true
    }
    
    override func shouldAutorotate() -> Bool {
        return allowRotate
    }
}

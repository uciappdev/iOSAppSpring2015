//
//  ImageViewController.swift
//  TableViewTemplate
//
//  Created by Jake on 6/3/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    // MARK: StoryBoard objects
    // Need a copy of the original image for resizeImage because 
    var originalImage : UIImage!
    var image : UIImage!
    // The name of the image file is passed from the previous ViewController
    var imageFileName : String!
    // An UIImageView that is resized to fit the size of the picture.
    let imageView = UIImageView()
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load the theme
        let isBeachTheme = NSUserDefaults.standardUserDefaults().boolForKey("isBeachThemeKey")
        loadTheme(isBeachTheme)
        // Image is loaded and copied to originalImage as well
        image = UIImage(named: imageFileName)
        originalImage = image
        // Resize the image to fit the screen.
        resizeImage()
        view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        // Resize the image whent he screen orientation is changed.
        resizeImage()
    }
    
    func resizeImage() {
        // Resize the image and place it in the middle of the screen. - Jake
        var navigationBarHeight = navigationController?.navigationBar.frame.height
        var height = view.frame.height - navigationBarHeight!
        var width = view.frame.width
        image = RBShrinkToFit(originalImage, CGSizeMake(width,height))
        imageView.frame = CGRectMake(0, navigationBarHeight!, image.size.width, image.size.height)
        imageView.image = image
        imageView.center = CGPoint(x: width/2, y: height/2+navigationBarHeight!)
    }
    
    func loadTheme(isBeachTheme: Bool) {
        if isBeachTheme {
            backgroundImage.image = UIImage(named: "beach.jpg")
        }
        else {
            backgroundImage.image = UIImage(named: "night-sky.jpg")
        }
    }
}

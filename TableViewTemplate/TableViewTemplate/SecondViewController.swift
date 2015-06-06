//
//  SecondViewController.swift
//  TableViewTemplate
//
//  Created by Jake on 6/3/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    // StoryBoard objects
    var originalImage : UIImage!
    var image : UIImage!
    var imageFileName : String!
    let imageView : UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        image = UIImage(named: imageFileName)
        originalImage = image
        resizeImage()
        view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
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
}

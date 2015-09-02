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
    var image : UIImage!
    
    // The name of the image file is passed from the previous ViewController
    var imageFileName : String!

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var selectedImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the theme
        let theme = defaults.stringForKey(keys[0])
        backgroundImage.image = UIImage(named: theme!)
        
        // Selected Image is loaded
        image = UIImage(named: imageFileName)
        selectedImage.image = image

    }
}

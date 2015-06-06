//
//  SurveyUINavigationController.swift
//  Survey_Question_Design_Demo
//
//  Created by Jake on 6/1/15.
//  Copyright (c) 2015 Jake Armentrout. All rights reserved.
//

import UIKit

class SurveyUINavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return visibleViewController.supportedInterfaceOrientations()
    }
    override func shouldAutorotate() -> Bool {
        return visibleViewController.shouldAutorotate()
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

//
//  OptionsTableViewController.swift
//  TableViewTemplate
//
//  Created by Jake on 8/19/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class OptionsTableViewController: UITableViewController {

    // Index in array represents the Section, the value represents the Row
    var lastSelectedIndexPathRows : [Int] = [find(themeData.fileNames, theme!)!, find(iconData.fileNames, icon!)!]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor.blackColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return count(optionsList)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numOfRows : Int
        switch section{
        case 0:
            numOfRows = count(themeData.fileNames)
        case 1:
            numOfRows = count(iconData.fileNames)
        default:
            numOfRows = 0
        }
        return numOfRows
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("optionCell", forIndexPath: indexPath) as! OptionsCustomTableViewCell
        var imagePath: String? = nil
        
        switch indexPath.section {
        case 0:
            imagePath = themeData.fileNames[indexPath.row]
        case 1:
            imagePath = iconData.fileNames[indexPath.row]
            
        default:
            println("Error: IndexPath out of bounds!")
        }
        
        cell.optionImage.image = UIImage(named: imagePath!)

        
        if indexPath.row == lastSelectedIndexPathRows[indexPath.section] {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return optionsList[section]
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // If the current IndexPath != lastSelectedIndexPath, uncheck previousCell and check currentCell. Set new lastSelectedIndex. Save new option.
        if indexPath.row != lastSelectedIndexPathRows[indexPath.section] {
            let previousCell = tableView.cellForRowAtIndexPath(NSIndexPath(forItem: lastSelectedIndexPathRows[indexPath.section], inSection: indexPath.section))
            previousCell?.accessoryType = UITableViewCellAccessoryType.None
            let currentCell = tableView.cellForRowAtIndexPath(indexPath)
            currentCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            lastSelectedIndexPathRows[indexPath.section] = indexPath.row
            switch indexPath.section {
            case 0:
                defaults.setObject(themeData.fileNames[indexPath.row], forKey: keys[0])
            case 1:
                defaults.setObject(iconData.fileNames[indexPath.row], forKey: keys[1])
            default:
                break
            }
            defaults.synchronize()
            
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Virtually removes the unused tableview cells
        return 0.01
    }
}

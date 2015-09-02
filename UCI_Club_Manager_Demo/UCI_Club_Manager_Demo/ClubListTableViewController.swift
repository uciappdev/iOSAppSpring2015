//
//  ClubListTableViewController.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 8/25/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit


class ClubListTableViewController: UITableViewController {
    var clubCollection = [Club]()// {didSet {populateSectionLookUp()}}
    var sectionLookUp = [0]
    
    func populateSectionLookUp () {
        var categoryTracker = clubCollection[0].category
        for (i,club) in enumerate(clubCollection) {
            if club.category != categoryTracker {
                sectionLookUp.append(i)
                categoryTracker = club.category
            }
        }
        sectionLookUp.append(clubCollection.count)
        println(sectionLookUp)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        var service = ClubService()
        //let qos = Int(QOS_CLASS_USER_INITIATED.value)
        
        service.getClubs {
            (response) in
            self.loadClubs(response)
        }
        
        
    }

    func loadClubs(clubs : NSArray) {
        
        for club in clubs{
            var id = (club["id"]! as! String).toInt()!
            var time_stamp = club["time_stamp"]! as! String
            var name = club["name"]! as! String
            var category = club["category"]! as! String
            
            var date_started = club["date_started"]! as! String
            var clubObj = Club(id: id, time_stamp: time_stamp, name: name, category: category, date_started: date_started)
            clubCollection.append(clubObj)
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
        populateSectionLookUp()
    }
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if sectionLookUp.count == 1 {
            return 1
        }
        println("number of sections: \(sectionLookUp.count - 2)")
        return sectionLookUp.count - 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if sectionLookUp.count == 1 {
            return clubCollection.count
        }
        //println("numberOfRowsInSection: \(section),\(sectionLookUp[section+1] - sectionLookUp[section])")
        return sectionLookUp[section+1] - sectionLookUp[section]
        
    }
    
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("club_cell", forIndexPath: indexPath) as! UITableViewCell
        // Configure the cell...
        
        
        if sectionLookUp.count == 1 {
            cell.textLabel!.text = clubCollection[indexPath.row].name
        }
        else {
            let clubCollectionIndex = sectionLookUp[indexPath.section] + indexPath.row
            cell.textLabel!.text = clubCollection[clubCollectionIndex].name
        }
        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sectionLookUp.count == 1 {
            return ""
        }
        
        return clubCollection[sectionLookUp[section]].category

    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let club = clubCollection[sectionLookUp[indexPath.section] + indexPath.row]
        performSegueWithIdentifier("toAbout", sender: self)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}



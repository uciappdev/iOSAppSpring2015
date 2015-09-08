//
//  ClubListTableViewController.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 8/25/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit


class ClubListTableViewController: UITableViewController {
    // Collection of all clubs.
    var clubCollection = [Club]()
    // Array used to help determine indexPaths for each club.
    // [0, ..., # of clubs]
    var sectionLookUp = [0]
    
    // Remember the club selected
    var selectedClub : Club?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Reset values if user returns to page.
        resetValues()
        
        // If values values need to be set, run DB web service.  Prevents infinite looping.
        if sectionLookUp.count == 1 {
            var service = Service()
            service.pull_club {
                (response) in
                self.loadClubs(response)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // If values not set yet...
        if sectionLookUp.count == 1 {
            return 1
        }
        return sectionLookUp.count - 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If values not set yet...
        if sectionLookUp.count == 1 {
            return clubCollection.count
        }
        return sectionLookUp[section+1] - sectionLookUp[section]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClubCell", forIndexPath: indexPath) as! UITableViewCell
        // Determine index through the sectionLookUp and set the cell's properties.
        let clubCollectionIndex = sectionLookUp[indexPath.section] + indexPath.row
        cell.textLabel!.text = clubCollection[clubCollectionIndex].name
        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // If values not set yet...
        if sectionLookUp.count == 1 {
            return ""
        }
        return clubCollection[sectionLookUp[section]].category
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Determine the selected club and initiate segue to ClubTabBarController
        let club = clubCollection[sectionLookUp[indexPath.section] + indexPath.row]
        selectedClub = club
        performSegueWithIdentifier("toTabBarController", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Set shared instance of the selected club
        if let tabBarController = segue.destinationViewController as? ClubTabBarController {
            tabBarController.club = selectedClub
        }
    }
    
    func resetValues() {
        // Reset all properties.
        clubCollection.removeAll(keepCapacity: true)
        sectionLookUp = [0]
        selectedClub = nil
    }
    
    func loadClubs(clubs : NSArray) {
        // Loop over Array of JSON dictionaries and create Club Objects.  Add Objects to the club collection, reload the table, then populate the section look up array.
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
    
    func populateSectionLookUp () {
        // Record the indexes where the club category changed.  Clubs are sorted by (Section, Alphabetical) when pulled from DB.
        var categoryTracker = clubCollection[0].category
        for (i,club) in enumerate(clubCollection) {
            if club.category != categoryTracker {
                sectionLookUp.append(i)
                categoryTracker = club.category
            }
        }
        sectionLookUp.append(clubCollection.count)
    }
}



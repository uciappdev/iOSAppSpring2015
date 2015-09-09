//
//  AnnouncementsTableViewController.swift
//  UCI_Club_Manager_Demo
//
//  Created by Jake on 9/1/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class AnnouncementsTableViewController: UITableViewController {
    
    // Set tableview heights for selected and unselected
    let SelectedCellHeight: CGFloat = 200.0
    let UnselectedCellHeight: CGFloat = 112.0
    
    var clubAnnouncements = [Announcement]()
    var lastSelectedCellIndexPath: NSIndexPath?

        override func viewDidLoad() {
        super.viewDidLoad()
        
        // If properties need to be set, call the web service.
        if clubAnnouncements.count == 0 {
            let tbc = self.tabBarController as! ClubTabBarController
            
            var service = Service()
            service.pull_announcements("\(tbc.club!.id)") {
                (response) in
                self.loadAnnouncements(response)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If properties haven't been set yet...
        if clubAnnouncements.count == 0 {
            return 0
        }
        return clubAnnouncements.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AnnouncementCell", forIndexPath: indexPath) as! AnnouncementTableViewCell
        cell.title!.text = clubAnnouncements[indexPath.row].title
        cell.subtitle!.text = clubAnnouncements[indexPath.row].subtitle
        cell.time_stamp!.text = clubAnnouncements[indexPath.row].time_stamp
        //cell.paragraph.text = clubAnnouncements[indexPath.row].paragraph
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! AnnouncementTableViewCell
        var text : String
        var resetIndex : NSIndexPath? = nil
        
        if let lastIndex = lastSelectedCellIndexPath {
            if lastIndex == indexPath {
                text = ""
                lastSelectedCellIndexPath = nil
            }
            else {
                resetIndex = lastIndex
                
                text = clubAnnouncements[indexPath.row].paragraph
                lastSelectedCellIndexPath = indexPath
            }
        }
        else {
            text = clubAnnouncements[indexPath.row].paragraph
            lastSelectedCellIndexPath = indexPath
        }

        tableView.beginUpdates()
        if let index = resetIndex {
            resetCell(index)
            resetIndex = nil
        }
        cell.paragraph.text = text
        cell.paragraph.sizeToFit()
        tableView.endUpdates()
    }
    

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let selectedCellIndexPath = lastSelectedCellIndexPath {
            if selectedCellIndexPath == indexPath {
                return SelectedCellHeight
            }
        }
        return UnselectedCellHeight
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Virtually removes the unused tableview cells
        return 0.01
    }
    
    func loadAnnouncements(announcements : NSArray) {
        // Create announcement objects and reload the table.
        for announcement in announcements{
            var id = announcement["id"]! as! String
            var time_stamp = announcement["time_stamp"]! as! String
            var club_id = announcement["club_id"]! as! String
            var title = announcement["title"]! as! String
            var subtitle = announcement["subtitle"] as! String
            var paragraph = announcement["paragraph"] as! String
            
            var clubObj = Announcement(id: id, time_stamp: time_stamp, club_id: club_id, title: title, subtitle: subtitle, paragraph: paragraph)
            clubAnnouncements.append(clubObj)
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    func resetCell (index: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(index) as! AnnouncementTableViewCell
        cell.paragraph.text = ""
        cell.paragraph.sizeToFit()
    }
}

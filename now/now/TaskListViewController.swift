//
//  TaskListViewController.swift
//  now
//
//  Created by Jeremie Lim on 3/7/16.
//  Copyright © 2016 CP3. All rights reserved.
//

// TODO:

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearView: UIView!
    
    // Set Nav Bar to use the light theme
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Make table view work
        tableView.delegate = self
        tableView.dataSource = self

        // Set table view row separator style
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
    }

    override func viewWillAppear(animated: Bool) {
        // Unpack the data into table
        let data = NSUserDefaults.standardUserDefaults().objectForKey("Tasks") as? NSData
        if data != nil {
            tasks = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [Task]
        }

        // Reload table
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Show empty state if there are no tasks
        checkIfEmptyState()
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell")! as! TaskTableViewCell

        // Store data in cell
        cell.taskLabel?.text = tasks[indexPath.row].taskName
        cell.taskCategory?.text = tasks[indexPath.row].categoryName.uppercaseString
        cell.taskTime?.text = "\(tasks[indexPath.row].time):00"
        
        // Set cell border radius
        cell.cellBackgroundView?.layer.cornerRadius = 4
        cell.cellBackgroundView?.layer.masksToBounds = true
        
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "startTaskSegue") {
            let destinationViewController = segue.destinationViewController as! TrackViewController

            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            //let task = tasks[indexPath!.row]

            print(indexPath!.row)
            destinationViewController.currentTask = indexPath!.row

            let localNotification = UILocalNotification()
            localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
            localNotification.alertBody = "Are you done with task?"
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1

            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)

        }
    }

    // Show table editing options
    // https://developer.apple.com/library/prerelease/ios/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Lesson9.html
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        // Check if the the button has delete
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // Remove item on table
            tasks.removeAtIndex(indexPath.row)

            // Convert new task to Binary format for NSUserDefaults
            let data = NSKeyedArchiver.archivedDataWithRootObject(tasks)

            // Add object to NS user defaults
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "Tasks")
            NSUserDefaults.standardUserDefaults().synchronize()

            let sections = NSIndexSet(index: 0)
            tableView.reloadSections(sections, withRowAnimation: .Automatic)

            // Show empty state if there are no tasks
            checkIfEmptyState()
        }
    }

    // Check if there are no tasks in list
    func checkIfEmptyState() {

        // Show empty state if array is empty
        if tasks.isEmpty  {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.tableView.alpha = 0
                self.clearView.alpha = 1
            })

        } else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.tableView.alpha = 1
                self.clearView.alpha = 0
            })
        }
    }



}

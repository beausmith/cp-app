//
//  TaskListViewController.swift
//  now
//
//  Created by Jeremie Lim on 3/7/16.
//  Copyright © 2016 CP3. All rights reserved.
//

// TODO:

import UIKit

var tasks: [Task] = [Task]()

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearView: UIView!
    
    var setClearedViewController: UIViewController!
    var fadeTransition: FadeTransition!
    
    // Set Nav Bar to use the light theme
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Initialize fade transition
        fadeTransition =  FadeTransition()

        // Make table view work
        tableView.delegate = self
        tableView.dataSource = self

        // Set table view row separator style
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        setClearedViewController = storyboard.instantiateViewControllerWithIdentifier("SetClearedViewController")
        
        clearView.addSubview(setClearedViewController.view)
        
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
            
        } else if (segue.identifier == "addTaskSegue") {
//            let destinationViewController = segue.destinationViewController as! AddTaskViewController
//            
//            destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
//            destinationViewController.transitioningDelegate = fadeTransition
//            fadeTransition.duration = 0.3
        }
    }
    
    // Check if there are no tasks in list
    func checkIfEmptyState() {
        
        // Show empty state if array is empty
        if tasks.isEmpty  {
            tableView.alpha = 0
            clearView.alpha = 1
            
            print("tasks is empty")
            
        } else {
            tableView.alpha = 1
            clearView.alpha = 0
            
            print("tasks is not empty")
        }
    }
    
    
    // TODO:
    // Figure out why view did appear is not firing with custom transitions

}

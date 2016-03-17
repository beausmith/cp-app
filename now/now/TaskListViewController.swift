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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make table view work
        tableView.delegate = self
        tableView.dataSource = self

        // Set table view row separator style
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    override func viewWillAppear(animated: Bool) {
        let curTaskCount = NSUserDefaults.standardUserDefaults().integerForKey("taskCount")
        
        // Show empty state if there are no tasks
        if curTaskCount == -1 {
            tableView.alpha = 0
        } else {
            tableView.alpha = 1
            clearView.alpha = 0
        }
        
        // Unpack the data into table
        let data = NSUserDefaults.standardUserDefaults().objectForKey("Tasks") as? NSData
        if data != nil {
            tasks = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [Task]
        }
        
        // Reload table
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell")! as! TaskTableViewCell
        
        // Store data in cell
        cell.taskLabel?.text = tasks[indexPath.row].taskName
        cell.taskCategory?.text = tasks[indexPath.row].categoryName
        cell.taskTime?.text = "\(tasks[indexPath.row].time):00"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as! TrackViewController
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let task = tasks[indexPath!.row]
        
        destinationViewController.currentTask = indexPath!.row
        
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
        localNotification.alertBody = "Are you done with task?"
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        
    }

    
}

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
    @IBOutlet weak var taskListHeaderView: UIView!

    var emptyStateViewController: UIViewController!
    var activeTasks = [Task]()
    var addTaskTransition: AddTaskTransition!
    var reflectTransition: FadeTransition!
    
    // Set Nav Bar to use the light theme
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize fade transition
        addTaskTransition = AddTaskTransition()
        reflectTransition = FadeTransition()

        // Make table view work
        tableView.delegate = self
        tableView.dataSource = self

        // Set table view row separator style
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None

        // Import empty state VC into main view
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        emptyStateViewController = storyboard.instantiateViewControllerWithIdentifier("emptyStateViewController")
        clearView.addSubview(emptyStateViewController.view)

    }

    override func viewWillAppear(animated: Bool) {
        // Unpack the data into table
        let data = NSUserDefaults.standardUserDefaults().objectForKey("Tasks") as? NSData
        if data != nil {
            tasks = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [Task]
        }

        activeTasks = [Task]()

        for task in tasks {
            if task.completed == true {
                print(task.taskName, "completed")
            } else {
                print(task.taskName, "active")
                activeTasks.append(task)
            }
        }
        print("---")

        // Reload table
        tableView.reloadData()
        
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {

        // Show empty state if there are no tasks
        checkIfEmptyState()
        
        super.viewDidAppear(animated)

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeTasks.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell")! as! TaskTableViewCell

        // Store data in cell
        cell.taskLabel?.text = activeTasks[indexPath.row].taskName
        cell.taskCategory?.text = activeTasks[indexPath.row].categoryName.uppercaseString
        cell.taskTime?.text = "\(activeTasks[indexPath.row].time):00"

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

            print("current task:", tasks[indexPath!.row].taskName, " @ row: ", indexPath!.row)
            destinationViewController.currentTask = indexPath!.row

        } else if (segue.identifier == "addTaskSegue") {
            let destinationViewController = segue.destinationViewController as! AddTaskViewController

            destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
            destinationViewController.transitioningDelegate = addTaskTransition
            addTaskTransition.duration = 0.3
        } else if (segue.identifier == "reflectSegue") {
            let destinationViewController = segue.destinationViewController as! ReflectViewController

            destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
            destinationViewController.transitioningDelegate = reflectTransition
            reflectTransition.duration = 0.3
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
            tableView.alpha = 0
            clearView.alpha = 1
        } else {
            tableView.alpha = 1
            clearView.alpha = 0
        }
    }



}

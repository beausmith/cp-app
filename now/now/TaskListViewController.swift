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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSUserDefaults.standardUserDefaults().setInteger(-1, forKey: "taskCount")
    }
    
    override func viewWillAppear(animated: Bool) {
        let curTaskCount = NSUserDefaults.standardUserDefaults().integerForKey("taskCount")
        
        if curTaskCount == -1 {
            tableView.alpha = 0
        } else {
            tableView.alpha = 1
            clearView.alpha = 0
        }
        
        let data = NSUserDefaults.standardUserDefaults().objectForKey("Tasks") as? NSData
        if data != nil {
            tasks = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [Task]
        }
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell")! as! TaskTableViewCell
        
        cell.taskLabel?.text = tasks[indexPath.row].taskName
        cell.taskCategory?.text = tasks[indexPath.row].categoryName
        cell.taskTime?.text = "\(tasks[indexPath.row].time):00"
        
        return cell
    }

}

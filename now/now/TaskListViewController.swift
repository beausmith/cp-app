//
//  TaskListViewController.swift
//  now
//
//  Created by Jeremie Lim on 3/7/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tasks = ["Task A", "Task B", "Task C"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell")! as! TaskTableViewCell
        
        cell.taskLabel.text = tasks[indexPath.row]
        
        return cell
    }
    
    @IBAction func addTask(sender: AnyObject) {
        tasks.append("Task D")
        print(tasks)
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

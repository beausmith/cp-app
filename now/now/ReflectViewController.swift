//
//  ReflectViewController.swift
//  now
//
//  Created by Beau Smith on 3/19/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import UIKit

class ReflectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var reflectTableView: UITableView!
    
    var cellHeight = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let completedTasks = [String!]
        //print(tasks.count)
        print(reflectTableView.frame.height, tasks.count)
        
        cellHeight = CGFloat(reflectTableView.frame.height) / CGFloat(tasks.count)

        // Make table view work
        reflectTableView.delegate = self
        reflectTableView.dataSource = self

        // Set table view row separator style
        self.reflectTableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

    override func viewWillAppear(animated: Bool) {
        
        // Show empty state if there are no tasks
        // checkIfEmptyState()
        
        // Unpack the data into table
        let data = NSUserDefaults.standardUserDefaults().objectForKey("Tasks") as? NSData
        if data != nil {
            tasks = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [Task]
        }
        
        // Reload table
        reflectTableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reflectTableCell")! as! ReflectTableViewCell
        
        // Store data in cell
        cell.taskNameLabel?.text = tasks[indexPath.row].taskName
        //cell.taskCategory?.text = tasks[indexPath.row].categoryName
        //cell.taskTime?.text = "\(tasks[indexPath.row].time):00"
        
        //cell.frame.height = self.cellHeight
        
        print(cell.frame.height)
        
        return cell
    }

    // Check if there are no tasks in list
//    func checkIfEmptyState() {
//        
//        // Show empty state if array is empty
//        if tasks.isEmpty  {
//            UIView.animateWithDuration(0.3, animations: { () -> Void in
//                self.tableView.alpha = 0
//                self.clearView.alpha = 1
//            })
//            
//        } else {
//            UIView.animateWithDuration(0.3, animations: { () -> Void in
//                self.tableView.alpha = 1
//                self.clearView.alpha = 0
//            })
//        }
//    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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

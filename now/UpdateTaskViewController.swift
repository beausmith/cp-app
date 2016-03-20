//
//  UpdateTaskViewController.swift
//  now
//
//  Created by Jess Lam on 3/9/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import UIKit

class UpdateTaskViewController: UIViewController {

    var trackTask: Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapCancel(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBAction func didTapInProgress(sender: UITapGestureRecognizer) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        if globalTaskTime == 0 {
            
            globalTaskTime = tasks[trackTask].time
            
        }
        
        
        
        
//        // Grab data from modal
//        let taskName = taskNameTextField.text
//        let categoryName = taskCategorySegementedControl.titleForSegmentAtIndex(taskCategorySegementedControl.selectedSegmentIndex)
//        let time = Int(taskTimeSegmentedControl.titleForSegmentAtIndex(taskTimeSegmentedControl.selectedSegmentIndex)!)
//        
//        // Add new task to the globals tasks array
//        tasks.insert(Task(withTaskName: taskName!, categoryName: categoryName!, time: time!, completed: Bool(false)), atIndex: 0)
//        
//        // Convert new task to Binary format for NSUserDefaults
//        let data = NSKeyedArchiver.archivedDataWithRootObject(tasks)
//        
//        // Add object to NS user defaults
//        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "Tasks")
//        
//        // Save NSUserDefaults
//        NSUserDefaults.standardUserDefaults().synchronize()

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

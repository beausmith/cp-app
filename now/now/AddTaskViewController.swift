//
//  AddTaskViewController.swift
//  now
//
//  Created by Jeremie Lim on 3/7/16.
//  Copyright © 2016 CP3. All rights reserved.
//

// TODO
// 1. Store value created in the main view list
// 2. Update table view controller with data

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskCategorySegementedControl: UISegmentedControl!
    @IBOutlet weak var taskTimeSegmentedControl: UISegmentedControl!
    
    var taskNumber : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add border to input field
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor
        border.frame = CGRect(x: 0, y: taskNameTextField.frame.size.height - width, width:  taskNameTextField.frame.size.width, height: taskNameTextField.frame.size.height)
        
        border.borderWidth = width
        taskNameTextField.layer.addSublayer(border)
        taskNameTextField.layer.masksToBounds = true
        
        // Auto focuskeyboard
        taskNameTextField.becomeFirstResponder()
    }
    
    @IBAction func didTapCancel(sender: AnyObject) {
        // Close modal
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didTapSave(sender: AnyObject) {
        let curTaskCount = NSUserDefaults.standardUserDefaults().integerForKey("taskCount")
        
        let defaultsKey = "Tasks"
        
        let taskName = taskNameTextField.text
        let categoryName = taskCategorySegementedControl.titleForSegmentAtIndex(taskCategorySegementedControl.selectedSegmentIndex)
        let time = Int(taskTimeSegmentedControl.titleForSegmentAtIndex(taskTimeSegmentedControl.selectedSegmentIndex)!)
        
        // Create a new Task object
        var newTask =  Task(withTaskName: taskName!, categoryName: categoryName!, andTime: time!)
        
        tasks.append(newTask)
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(tasks)
        
        // Add object to NS user defaults
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: defaultsKey)
        
        NSUserDefaults.standardUserDefaults().setInteger(curTaskCount + 1, forKey: "taskCount")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}

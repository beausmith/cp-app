//
//  AddTaskViewController.swift
//  now
//
//  Created by Jeremie Lim on 3/7/16.
//  Copyright © 2016 CP3. All rights reserved.
//
import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskCategorySegementedControl: UISegmentedControl!
    @IBOutlet weak var taskTimeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var addTaskParentView: UIView!
    
    var taskNumber : Int!
    
    // Set Nav Bar to use the light theme
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set add task parent background radius
        addTaskParentView.layer.cornerRadius = 4
        addTaskParentView.layer.masksToBounds = true
        
        // Add shadow to parent background
        addTaskParentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor
        addTaskParentView.layer.shadowOffset = CGSizeMake(3, 3)
        addTaskParentView.layer.shadowRadius = 3
        
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
        // Grab data from modal
        let taskName = taskNameTextField.text
        let categoryName = taskCategorySegementedControl.titleForSegmentAtIndex(taskCategorySegementedControl.selectedSegmentIndex)
        let time = Int(taskTimeSegmentedControl.titleForSegmentAtIndex(taskTimeSegmentedControl.selectedSegmentIndex)!)
        
        // Add new task to the globals tasks array
        tasks.insert(Task(withTaskName: taskName!, categoryName: categoryName!, time: time!, completed: Bool(false)), atIndex: 0)
        
        // Convert new task to Binary format for NSUserDefaults
        let data = NSKeyedArchiver.archivedDataWithRootObject(tasks)
        
        // Add object to NS user defaults
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "Tasks")
        
        // Save NSUserDefaults
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
    }
    
}

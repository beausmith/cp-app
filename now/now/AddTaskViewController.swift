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
        // Grab data from modal
        let taskName = taskNameTextField.text
        let categoryName = taskCategorySegementedControl.titleForSegmentAtIndex(taskCategorySegementedControl.selectedSegmentIndex)
        let time = Int(taskTimeSegmentedControl.titleForSegmentAtIndex(taskTimeSegmentedControl.selectedSegmentIndex)!)
        
        // Add new task to the globals tasks array
        tasks.append(Task(withTaskName: taskName!, categoryName: categoryName!, andTime: time!))
        
        // Convert new task to Binary format for NSUserDefaults
        let data = NSKeyedArchiver.archivedDataWithRootObject(tasks)
        
        // Add object to NS user defaults
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "Tasks")
        
        // Save NSUserDefaults
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}

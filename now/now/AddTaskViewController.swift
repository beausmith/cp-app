//
//  AddTaskViewController.swift
//  now
//
//  Created by Jeremie Lim on 3/7/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    var taskName: String = ""
    
    @IBOutlet weak var taskNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let taskListViewController = segue.destinationViewController as! TaskListViewController
        taskListViewController.tasks.append(taskNameTextField.text!)
    }

}

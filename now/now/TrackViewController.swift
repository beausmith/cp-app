//
//  TrackViewController.swift
//  now
//
//  Created by Jess Lam on 3/9/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import UIKit

class TrackViewController: UIViewController {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskTime: UILabel!
    @IBOutlet weak var taskCategory: UILabel!
    

    
    var taskNumber: Int!
    
    var currentTask: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                            
        // Unpack the data into table
        let data = NSUserDefaults.standardUserDefaults().objectForKey("Tasks") as? NSData
        if data != nil {
            tasks = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [Task]
        }
        
        //print("\(tasks[currentTask].taskName) \(tasks[currentTask].categoryName) \(tasks[currentTask].time):00")
        
        taskName.text = tasks[currentTask].taskName
        
        taskTime.text = String(tasks[currentTask].time)
        
        taskCategory.text = tasks[currentTask].categoryName
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

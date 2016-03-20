//
//  TrackViewController.swift
//  now
//
//  Created by Jess Lam on 3/9/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import UIKit

var globalTaskTime = 0

class TrackViewController: UIViewController {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskTime: UILabel!
    @IBOutlet weak var taskCategory: UILabel!

    var taskNumber: Int!
    
    var currentTask: Int!
    
    var count: Int!
    
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Unpack the data into table
        let data = NSUserDefaults.standardUserDefaults().objectForKey("Tasks") as? NSData
        if data != nil {
            tasks = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [Task]
        }
        
        
        
        print(globalTaskTime)
        
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
    
    override func viewDidAppear(animated: Bool) {
        
        globalTaskTime = tasks[currentTask].time
        
        count = globalTaskTime
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
    }
    
    
    func update() {
        if(count > 0)
        {
            count = count - 1
            taskTime.text = String(count)
            
        } else if (count == 0) {
    
            performSegueWithIdentifier("timerDoneSegue", sender: nil)
            
            timer.invalidate()
        }
        
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

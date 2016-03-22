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
        
        taskTime.text = "\(tasks[currentTask].time):00"
        
        taskCategory.text = tasks[currentTask].categoryName
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        globalTaskTime = Int(tasks[currentTask].time)*60
        
        count = globalTaskTime
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
    }
    
    
    func update() {        
        if(count > 0)
        {
            count = count - 1
            
            var elapsedTime: NSTimeInterval = Double(count)
            
            //calculate the minutes in elapsed time.
            let minutes = UInt8(elapsedTime / 60.0)
            elapsedTime -= (NSTimeInterval(minutes) * 60)
            
            //calculate the seconds in elapsed time.
            let seconds = UInt8(elapsedTime)
            elapsedTime -= NSTimeInterval(seconds)
            
            //add the leading zero for minutes, seconds and millseconds and store them as string constants
            
            let strMinutes = String(format: "%02d", minutes)
            let strSeconds = String(format: "%02d", seconds)
            
            taskTime.text = "\(strMinutes):\(strSeconds)"
            
        } else if (count == 0) {
    
            performSegueWithIdentifier("timerDoneSegue", sender: nil)
            
            timer.invalidate()
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        let destinationViewController = segue.destinationViewController as! UpdateTaskViewController
        
        destinationViewController.trackTask = currentTask
        
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    */

}

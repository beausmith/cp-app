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
    
    var taskListViewController: TaskListViewController!
    
    var trackTask: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Unpack the data into table
        let data = NSUserDefaults.standardUserDefaults().objectForKey("Tasks") as? NSData
        if data != nil {
            tasks = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [Task]
        }

        taskName.text = tasks[currentTask].taskName

        taskTime.text = "\(tasks[currentTask].time):00"

        taskCategory.text = tasks[currentTask].categoryName

        //print(globalTaskTime)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {

        globalTaskTime = Int(tasks[currentTask].time)*60

        count = globalTaskTime

        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("update"), userInfo: nil, repeats: true)

        //print(count)

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

//            performSegueWithIdentifier("timerDoneSegue", sender: nil)

            timer.invalidate()
        }
    }

    // Commented this out since we don't segue to UpdateTask vc anymore.
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let destinationViewController = segue.destinationViewController as! UpdateTaskViewController
//        destinationViewController.trackTask = currentTask
//        timer.invalidate()
//        destinationViewController.trackViewController = self
//    }

    func currentTaskCompleted() {
        // log event for current task
        tasks[currentTask].completed = true

        // Convert new task to Binary format for NSUserDefaults
        let data = NSKeyedArchiver.archivedDataWithRootObject(tasks)

        // Add object to NS user defaults
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "Tasks")

        // Save NSUserDefaults
        NSUserDefaults.standardUserDefaults().synchronize()

        backHome()

        // is there a next task?
            // Start the next task
            // trackViewController.startNextTask()
            // Dismiss modal
        // else
            // Dismiss modal
            // dismissViewControllerAnimated(true, completion: nil)
            // Go back to home
            // trackViewController.backHome()

    }

    func backHome() {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func didTapStop(sender: AnyObject) {
        // record Event
        backHome()
    }
    
    @IBAction func didTapSwitch(sender: UIButton) {
        // log event for current task
        // Dismiss modal
//        dismissViewControllerAnimated(true, completion: nil)
        
        performSegueWithIdentifier("tapSwitchSegue", sender: nil)
        timer.invalidate()
        // Go back to home
//        taskListViewController.backHome()
    }
    
    @IBAction func didTapDone(sender: UIButton) {
          // how to set task to completed
//        taskListViewController.currentTaskCompleted()
        performSegueWithIdentifier("tapDoneSegue", sender: nil)
        timer.invalidate()
        
        // Need to remove current task from task list vc
        
    }
    
    @IBAction func didTapInProgress(sender: UIButton) {
        //Reset timer to original task time
                if globalTaskTime == 0 {
                    globalTaskTime = tasks[trackTask].time
                }
    }
    
    
}

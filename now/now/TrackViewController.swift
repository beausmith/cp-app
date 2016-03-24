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

    @IBOutlet weak var inProgressButton: UIButton!
    var taskNumber: Int!

    var currentTask: Int!

    var currentTaskSeconds: Int = 0

    var timer: NSTimer!
    
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

        currentTaskSeconds = Int(tasks[currentTask].time)*60

        startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(TrackViewController.countdown), userInfo: nil, repeats: true)
        setNotification()
        // disable "in progress" button
        inProgressButton.enabled = false
        inProgressButton.alpha = 0.4
    }

    func setNotification() {
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: Double(currentTaskSeconds/60))
        localNotification.alertBody = "Are you done with \(tasks[currentTask].taskName)?"
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

    func countdown() {
        if (currentTaskSeconds > 0) {

            currentTaskSeconds -= 1

            var elapsedTime: NSTimeInterval = Double(currentTaskSeconds)

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

        } else if (currentTaskSeconds == 0) {
            timer.invalidate()
            // enable "in progress" button
            inProgressButton.enabled = true
            inProgressButton.alpha = 1
        }
    }

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
        
        // Stop timer
        timer.invalidate()
        
        print("did tap switch")
        
        // Return home
        backHome()

    }
    
    @IBAction func didTapDone(sender: UIButton) {
       // how to set task to completed
        currentTaskCompleted()
        
        // Return home
        backHome()
        
        //Stop timer
        timer.invalidate()
        
    }
    
    @IBAction func didTapInProgress(sender: UIButton) {
        
        currentTaskSeconds = Int(tasks[currentTask].time)*60
        
        startTimer()
        
    }
    

    
    
}

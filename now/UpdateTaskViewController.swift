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
    var trackViewController: TrackViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func didTapInProgress(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
        // Reset timer to original task time
//        if globalTaskTime == 0 {
//            globalTaskTime = tasks[trackTask].time
//        }
    }

    @IBAction func didTapSwitch(sender: AnyObject) {
        // log event for current task
        // Dismiss modal
        dismissViewControllerAnimated(true, completion: nil)
        // Go back to home
        trackViewController.backHome()
    }

    @IBAction func didTapCompleted(sender: AnyObject) {
        trackViewController.currentTaskCompleted()
        dismissViewControllerAnimated(true, completion: nil)
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

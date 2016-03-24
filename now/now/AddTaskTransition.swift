//
//  AddTaskTransition.swift
//  now
//
//  Created by Lim, Jeremie on 3/23/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import UIKit

class AddTaskTransition: BaseTransition {
    
    var taskFrame: UIView!
    var overlayFrame: UIView!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        //        let taskListViewController = fromViewController as! TaskListViewController
        //        let addTaskController = toViewController as! AddTaskViewController
        //
        //        taskListViewController.view.taskListHeaderView.alpha = 0
        
        toViewController.view.alpha = 0
        
        overlayFrame = UIView()
        overlayFrame.frame = CGRect(x: 0, y: 0, width: 320, height: 640)
        overlayFrame.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        overlayFrame.alpha = 0
        
        
        containerView.addSubview(overlayFrame)
        
        taskFrame = UIView()
        taskFrame.frame = CGRect(x: 16, y: 540, width: 288, height: 358)
        taskFrame.backgroundColor = UIColor.whiteColor()
        taskFrame.layer.cornerRadius = 4
        taskFrame.layer.masksToBounds = true
        
        containerView.addSubview(taskFrame)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: [], animations: { () -> Void in
                self.taskFrame.frame = CGRect(x: 16, y: 80, width: 288, height: 358)
                self.overlayFrame.alpha = 1
            
            }) { (Bool) -> Void in
                self.taskFrame.alpha = 0
                self.overlayFrame.alpha = 0
                
                toViewController.view.alpha = 1
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        fromViewController.view.alpha = 0
        overlayFrame.alpha = 1
        taskFrame.alpha = 1
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: [], animations: { () -> Void in
            
            self.overlayFrame.alpha = 0
            self.taskFrame.frame = CGRect(x: 16, y: 640, width: 288, height: 358)
            
            }) { (Bool) -> Void in
                toViewController.viewWillAppear(true)
                toViewController.viewDidAppear(true)
                
                self.finish()
        }

    }
}

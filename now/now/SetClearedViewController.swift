//
//  SetClearedViewController.swift
//  now
//
//  Created by Lim, Jeremie on 3/22/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import UIKit

class SetClearedViewController: UIViewController {

    @IBOutlet weak var sunRaysImageView: UIImageView!
    @IBOutlet weak var sunCenterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sunRaysImageView.transform = CGAffineTransformMakeScale(0, 0)
        sunCenterImageView.transform = CGAffineTransformMakeScale(0, 0)
        
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: { () -> Void in
            
                self.sunRaysImageView.transform = CGAffineTransformMakeScale(1, 1)
                self.sunCenterImageView.transform = CGAffineTransformMakeScale(1, 1)
            
            }, completion: nil)
    }
    
    

}

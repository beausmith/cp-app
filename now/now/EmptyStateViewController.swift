//
//  EmptyStateViewController.swift
//  now
//
//  Created by Lim, Jeremie on 3/22/16.
//  Copyright © 2016 CP3. All rights reserved.
//

import UIKit

class EmptyStateViewController: UIViewController {

    @IBOutlet weak var sunRaysImageView: UIImageView!
    @IBOutlet weak var sunCenterImageView: UIImageView!

    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var emptyTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize sun sizes
        sunRaysImageView.transform = CGAffineTransformMakeScale(0, 0)
        sunCenterImageView.transform = CGAffineTransformMakeScale(0, 0)

        // Scale the sun
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: { () -> Void in

            self.sunRaysImageView.transform = CGAffineTransformMakeScale(1, 1)
            self.sunCenterImageView.transform = CGAffineTransformMakeScale(1, 1)

            }, completion: nil)

        // Rotate the sun rays
        UIView.animateWithDuration(20, delay: 0, options: [.Repeat,.CurveLinear], animations: { () -> Void in
            self.sunRaysImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            }, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        print("enmptystate:", tasks.count)
        if tasks.count == 0 {
            emptyTitleLabel.text = "Now is the time!"
            emptyTextLabel.text = "Add some tasks to get started."
        } else {
            emptyTitleLabel.text = "You’re all done!"
            emptyTextLabel.text = "Kick back, pour yourself a cold one, and enjoy the sunshine."
        }

    }

}

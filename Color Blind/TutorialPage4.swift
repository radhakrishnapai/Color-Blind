//
//  TutorialPage4.swift
//  Color Blind
//
//  Created by qbuser on 01/07/16.
//  Copyright © 2016 Pai. All rights reserved.
//

import UIKit

class TutorialPage4: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    var timeLeft = 4
    var timer:NSTimer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(TutorialPage4.startAnimations), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.timer?.valid == false {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(TutorialPage4.startAnimations), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
    }
    
    func startAnimations() {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            dispatch_async(dispatch_get_main_queue(), {
                self.timeLabel.text = "\(self.timeLeft)"
                if self.timeLeft == 0 {
                    self.timeLeft = 6
                }
                self.timeLeft -= 1
            })
        })
    }
}

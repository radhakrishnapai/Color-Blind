//
//  TutorialPage1.swift
//  Color Blind
//
//  Created by qbuser on 29/06/16.
//  Copyright © 2016 Pai. All rights reserved.
//

import UIKit

class TutorialPage1: UIViewController {
    @IBOutlet weak var textLabel: UILabel!    
    @IBOutlet weak var colorLabel: UILabel!
    var toggle = true
    var t3 = 1.0
    var turn = false
    
    var textLabelTransform:CGAffineTransform = CGAffineTransform()
    var colorLabelTransform:CGAffineTransform = CGAffineTransform()
    var timer:NSTimer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textLabelTransform = self.textLabel.transform
        self.colorLabelTransform = self.colorLabel.transform
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.008, target: self, selector: #selector(TutorialPage1.startAnimations), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.timer?.valid == false {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.008, target: self, selector: #selector(TutorialPage1.startAnimations), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
    }
    
    func startAnimations() {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            dispatch_async(dispatch_get_main_queue(), {
                if self.turn {
                    self.textLabel.transform = CGAffineTransformScale(self.textLabelTransform, CGFloat(self.t3), CGFloat(self.t3))
                } else {
                    self.colorLabel.transform = CGAffineTransformScale(self.colorLabelTransform, CGFloat(self.t3), CGFloat(self.t3))
                }
            })
            
            if self.t3 >= 1.5 {
                self.toggle = true
                
            } else if self.t3 <= 1 {
                self.toggle = false
                if self.turn == true {
                    self.turn = false
                } else {
                    self.turn = true
                }
            }
            
            if self.toggle {
                self.t3 -= 0.005
            } else {
                self.t3 += 0.005
            }
            
        })
    }
}

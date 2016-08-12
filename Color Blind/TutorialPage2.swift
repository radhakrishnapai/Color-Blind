//
//  File.swift
//  Color Blind
//
//  Created by qbuser on 29/06/16.
//  Copyright © 2016 Pai. All rights reserved.
//

import UIKit

class TutorialPage2: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var redButton: UIButton!
    var toggle = true
    var t3 = 1.0
    var turn = 3
    
    var textLabelTransform:CGAffineTransform = CGAffineTransform()
    var colorLabelTransform:CGAffineTransform = CGAffineTransform()
    var redButtonTransform:CGAffineTransform = CGAffineTransform()
    var timer:NSTimer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textLabelTransform = self.textLabel.transform
        self.colorLabelTransform = self.colorLabel.transform
        self.redButtonTransform = self.redButton.transform
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.015, target: self, selector: #selector(TutorialPage2.startAnimations), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.timer?.valid == false {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.015, target: self, selector: #selector(TutorialPage2.startAnimations), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
    }
    
    func startAnimations() {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            dispatch_async(dispatch_get_main_queue(), {
                switch self.turn {
                case 1:
                    self.textLabel.font = UIFont(name: "Comfortaa-Bold", size: 25+CGFloat((self.t3 - 1)*30))
                case 2:
                    self.colorLabel.font = UIFont(name: "Comfortaa-Bold", size: 25+CGFloat((self.t3 - 1)*30))
                case 3:
                    self.redButton.transform = CGAffineTransformScale(self.colorLabelTransform, CGFloat(self.t3), CGFloat(self.t3))
                default:break
                }
            })
            
            if self.t3 >= 1.1 {
                self.toggle = true
                
            } else if self.t3 <= 1 {
                self.toggle = false
                switch self.turn {
                case 1:self.turn = 2
                case 2:self.turn = 3
                case 3:self.turn = 1
                default:self.turn = 1
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
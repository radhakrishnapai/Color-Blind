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
    var timer:Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textLabelTransform = self.textLabel.transform
        self.colorLabelTransform = self.colorLabel.transform
        self.timer = Timer.scheduledTimer(timeInterval: 0.008, target: self, selector: #selector(TutorialPage1.startAnimations), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.timer?.isValid == false {
            self.timer = Timer.scheduledTimer(timeInterval: 0.008, target: self, selector: #selector(TutorialPage1.startAnimations), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
    }
    
    @objc func startAnimations() {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            DispatchQueue.main.async(execute: {
                if self.turn {
                    self.textLabel.transform = self.textLabelTransform.scaledBy(x: CGFloat(self.t3), y: CGFloat(self.t3))
                } else {
                    self.colorLabel.transform = self.colorLabelTransform.scaledBy(x: CGFloat(self.t3), y: CGFloat(self.t3))
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

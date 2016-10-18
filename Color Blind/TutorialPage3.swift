//
//  TutorialPage3.swift
//  Color Blind
//
//  Created by qbuser on 29/06/16.
//  Copyright © 2016 Pai. All rights reserved.
//

import UIKit

class TutorialPage3: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var redButton: UIButton!
    var toggle = true
    var t3 = 1.0
    var turn = 3
    
    var textLabelTransform:CGAffineTransform = CGAffineTransform()
    var colorLabelTransform:CGAffineTransform = CGAffineTransform()
    var redButtonTransform:CGAffineTransform = CGAffineTransform()
    var timer:Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textLabelTransform = self.textLabel.transform
        self.colorLabelTransform = self.colorLabel.transform
        self.redButtonTransform = self.redButton.transform
        self.timer = Timer.scheduledTimer(timeInterval: 0.015, target: self, selector: #selector(TutorialPage3.startAnimations), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.timer?.isValid == false {
            self.timer = Timer.scheduledTimer(timeInterval: 0.015, target: self, selector: #selector(TutorialPage3.startAnimations), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
    }
    
    func startAnimations() {
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
            DispatchQueue.main.async(execute: {
                switch self.turn {
                case 1:
                    self.textLabel.font = UIFont(name: "Comfortaa-Bold", size: 25+CGFloat((self.t3 - 1)*30))
                case 2:
                    self.colorLabel.font = UIFont(name: "Comfortaa-Bold", size: 25+CGFloat((self.t3 - 1)*30))
                case 3:
                    self.redButton.transform = self.colorLabelTransform.scaledBy(x: CGFloat(self.t3), y: CGFloat(self.t3))
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

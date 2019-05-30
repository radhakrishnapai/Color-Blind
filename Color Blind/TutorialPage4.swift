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
    var timer:Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TutorialPage4.startAnimations), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.timer?.isValid == false {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TutorialPage4.startAnimations), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
    }
    
    @objc func startAnimations() {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            DispatchQueue.main.async(execute: {
                self.timeLabel.text = "\(self.timeLeft)"
                if self.timeLeft == 0 {
                    self.timeLeft = 6
                }
                self.timeLeft -= 1
            })
        })
    }
}

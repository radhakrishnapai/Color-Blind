//
//  BaseViewController.swift
//  Color Blind
//
//  Created by qbuser on 28/06/16.
//  Copyright © 2016 Pai. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    var t1 = 1.0
    var t2 = 1.0
    var timer:Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer = Timer.scheduledTimer(timeInterval: 0.045, target: self, selector: #selector(BaseViewController.startAnimations), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.timer?.isValid == false {
            self.timer = Timer.scheduledTimer(timeInterval: 0.045, target: self, selector: #selector(BaseViewController.startAnimations), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
    }
    
    func startAnimations() {        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
            
            let r1 = 20.0
            let x1 = r1 * sin(self.t1) + 270
            let y1 = r1 * cos(self.t1) + 450
            
            let r2 = 30.0
            let x2 = r2 * sin(self.t2) + 250
            let y2 = r2 * cos(self.t2) + 800
            
            let r3 = 10.0
            let x3 = r3 * sin(self.t1) + 650
            let y3 = r3 * cos(self.t1) + 500
            
            let r4 = 15.0
            let x4 = r4 * sin(self.t2) + 700
            let y4 = r4 * cos(self.t2) + 900
            
            DispatchQueue.main.async(execute: {
                self.greenView.center = CGPoint(x: CGFloat(x1), y: CGFloat(y1))
                self.yellowView.center = CGPoint(x: CGFloat(x2), y: CGFloat(y2))
                self.blueView.center = CGPoint(x: CGFloat(x3), y: CGFloat(y3))
                self.redView.center = CGPoint(x: CGFloat(x4), y: CGFloat(y4))
            })
            self.t1 += 0.01
            self.t2 -= 0.01
        })
    }
}

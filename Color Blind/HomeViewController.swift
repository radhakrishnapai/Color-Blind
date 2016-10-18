//
//  ViewController.swift
//  Color Blind
//
//  Created by qbuser on 10/06/16.
//  Copyright © 2016 Pai. All rights reserved.
//

import UIKit
import Darwin

class HomeViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var toggle = true
    var t3 = 1.0
    var transform:CGAffineTransform = CGAffineTransform()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transform = self.playButton.transform
    }

    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
        
    }
}


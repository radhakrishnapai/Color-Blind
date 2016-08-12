//
//  SettingsViewController.swift
//  Color Blind
//
//  Created by qbuser on 23/06/16.
//  Copyright © 2016 Pai. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var alertViewBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func tappedOnUsername(sender: AnyObject) {
        self.usernameView.hidden = false
        self.usernameTextField.becomeFirstResponder()
    }
    @IBAction func tappedOnTintView(sender: AnyObject) {
        self.usernameTextField.resignFirstResponder()
        self.usernameView.hidden = true
    }
}
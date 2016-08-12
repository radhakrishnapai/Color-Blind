//
//  GameViewController.swift
//  Color Blind
//
//  Created by qbuser on 10/06/16.
//  Copyright © 2016 Pai. All rights reserved.
//

import UIKit

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
    
    func randomElement() -> Generator.Element {
        return Array(self)[Int(arc4random_uniform(UInt32(Array(self).count)))]
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1) {
        assert(hex[hex.startIndex] == "#", "Expected hex string of format #RRGGBB")
        
        let scanner = NSScanner(string: hex)
        scanner.scanLocation = 1  // skip #
        
        var rgb: UInt32 = 0
        scanner.scanHexInt(&rgb)
        
        self.init(
            red:   CGFloat((rgb & 0xFF0000) >> 16)/255.0,
            green: CGFloat((rgb &   0xFF00) >>  8)/255.0,
            blue:  CGFloat((rgb &     0xFF)      )/255.0,
            alpha: alpha)
    }
}

let texts:[String] = ["Blue", "Red", "Green", "Yellow"]
let question:[String] = ["COLOR", "TEXT"]
let redColor = UIColor.init(hex: "#FF4446")
let blueColor = UIColor.init(hex: "#5D95FF")
let greenColor = UIColor.init(hex: "#4BCEB6")
let yellowColor = UIColor.init(hex: "#E8CB2C")
let lightGreyColor = UIColor.init(hex: "#DCDCDC")
var colors = [blueColor, redColor, greenColor, yellowColor]
let gameColors = ["Blue":blueColor, "Red":redColor, "Green":greenColor, "Yellow":yellowColor]
var timerInterval = 20

class GameViewController: UIViewController {
    
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet var buttonsArray: [UIButton]!
    @IBOutlet weak var questionFirstPartLabel: UILabel!
    @IBOutlet weak var questionSecondPartLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet var pauseView: UIView!
    var timer:NSTimer?
    var timeLeft = 0, score = -5, level = 1, questionCount = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restartGame()
    }
    
    func resetValues() {
        self.timer = nil
        self.timeLeft = 15
        self.score = -5
        self.level = 1
        self.questionCount = 0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.orientationHandling(UIApplication.sharedApplication().statusBarOrientation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pauseButtonTapped(sender: AnyObject) {
        self.pauseView.hidden = false;
        self.timer!.invalidate()
    }
    
    @IBAction func resumeButtonTapped(sender: AnyObject) {
        self.pauseView.hidden = true;
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GameViewController.updateTime), userInfo: nil, repeats: true)
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.orientationHandling(toInterfaceOrientation)
    }
    
    func orientationHandling(orientation:UIInterfaceOrientation) {
        switch orientation {
        case UIInterfaceOrientation.Portrait, UIInterfaceOrientation.PortraitUpsideDown:
            self.questionFirstPartLabel.textAlignment = NSTextAlignment.Right
            self.questionSecondPartLabel.textAlignment = NSTextAlignment.Left
            self.questionView.backgroundColor = UIColor.whiteColor()
        case UIInterfaceOrientation.LandscapeLeft, UIInterfaceOrientation.LandscapeRight:
            self.questionFirstPartLabel.textAlignment = NSTextAlignment.Center
            self.questionSecondPartLabel.textAlignment = NSTextAlignment.Center
            self.questionView.backgroundColor = lightGreyColor
        default: break
        }
    }
    
    func randomise() {
        self.timeLeft += 5
        self.score += 5
        self.questionCount += 1
        
        if self.questionCount == 10 {
            self.level += 1
            self.questionCount = 0
        }
        
        let colorsArray = colors.shuffle()
        let textsArray = texts.shuffle()
        for (index, button) in self.buttonsArray.enumerate() {
            button.backgroundColor = colorsArray[index]
            button.setTitle(textsArray[index], forState: UIControlState.Normal)
        }
        self.questionFirstPartLabel.text = question.randomElement()
        self.questionSecondPartLabel.text = texts.randomElement()
        self.questionSecondPartLabel.textColor = colors.randomElement()
        self.timerLabel.text = "\(self.timeLeft)"
        self.scoreLabel.text = "\(self.score)"
        self.levelLabel.text = "\(self.level)"
        self.animateButtons()        
    }
    
    func animateButtons() {
        self.buttonsArray[0].transform = CGAffineTransformMakeScale(1.2, 1.2)
        UIView.animateWithDuration(0.1, animations: {
            self.buttonsArray[0].transform = CGAffineTransformMakeScale(1, 1)
            self.buttonsArray[1].transform = CGAffineTransformMakeScale(1.2, 1.2)
        }) { (true) in
            UIView.animateWithDuration(0.1, animations: {
                self.buttonsArray[1].transform = CGAffineTransformMakeScale(1, 1)
                self.buttonsArray[2].transform = CGAffineTransformMakeScale(1.2, 1.2)
                }, completion: { (true) in
                    UIView.animateWithDuration(0.1, animations: {
                        self.buttonsArray[2].transform = CGAffineTransformMakeScale(1, 1)
                        self.buttonsArray[3].transform = CGAffineTransformMakeScale(1.2, 1.2)
                        }, completion: { (true) in
                            UIView.animateWithDuration(0.1, animations: {
                                self.buttonsArray[3].transform = CGAffineTransformMakeScale(1, 1)
                            })
                    })
            })
        }
    }
    
    func updateTime() {
        self.timeLeft -= 1
        self.timerLabel.text = "\(timeLeft)"
        if self.timeLeft <= 0 {
            self.stopGame()
        }
    }
    
    func stopGame() {
        self.timer!.invalidate()
        self.gameOverLabel.text = "Game Over!\n Your final score is"
        self.finalScoreLabel.text = "\(self.score)"
        self.scoreView.hidden = false
        self.updateHighScore()
    }
    
    func updateHighScore() {
        
        let newEntry = LeaderBoardEntry(name: "No_Name", score: self.score, level: self.level)
        
        var data = LeaderBoardEntry.getLeaderboardData()
            
            for (index, leaderBoardEntry) in data.enumerate() {
                if newEntry.score >= leaderBoardEntry.score  {
                    data.insert(newEntry, atIndex: index)
                    break
                }
            }
            
            if data.count > 5 {
                data.removeRange(5..<data.count)
            }
            
            LeaderBoardEntry.setLeaderboardData(data)
    }
    
    @IBAction func restartGame() {
        self.resetValues()
        self.randomise()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GameViewController.updateTime), userInfo: nil, repeats: true)
        self.scoreView.hidden = true
        self.pauseView.hidden = true
    }
    
    
    @IBAction func colorButtonTapped(button: UIButton) {
        switch self.questionFirstPartLabel.text! {
        case "COLOR":
            if button.backgroundColor!.isEqual(gameColors[self.questionSecondPartLabel.text!]) {
                self.randomise()
            } else {
                self.stopGame()
            }
            
            case "TEXT":
                if button.titleForState(UIControlState.Normal)! == self.questionSecondPartLabel.text {
                    self.randomise()
                } else {
                    self.stopGame()
            }
            
        default:
            self.stopGame()
        }
    }
}

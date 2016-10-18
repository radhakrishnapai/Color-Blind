//
//  GameViewController.swift
//  Color Blind
//
//  Created by qbuser on 10/06/16.
//  Copyright © 2016 Pai. All rights reserved.
//

import UIKit

extension Collection {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
    
    func randomElement() -> Iterator.Element {
        return Array(self)[Int(arc4random_uniform(UInt32(Array(self).count)))]
    }
}

extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1) {
        assert(hex[hex.startIndex] == "#", "Expected hex string of format #RRGGBB")
        
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1  // skip #
        
        var rgb: UInt32 = 0
        scanner.scanHexInt32(&rgb)
        
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
    var timer:Timer?
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.orientationHandling(UIApplication.shared.statusBarOrientation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pauseButtonTapped(_ sender: AnyObject) {
        self.pauseView.isHidden = false;
        self.timer!.invalidate()
    }
    
    @IBAction func resumeButtonTapped(_ sender: AnyObject) {
        self.pauseView.isHidden = true;
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.updateTime), userInfo: nil, repeats: true)
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.orientationHandling(toInterfaceOrientation)
    }
    
    func orientationHandling(_ orientation:UIInterfaceOrientation) {
        switch orientation {
        case UIInterfaceOrientation.portrait, UIInterfaceOrientation.portraitUpsideDown:
            self.questionFirstPartLabel.textAlignment = NSTextAlignment.right
            self.questionSecondPartLabel.textAlignment = NSTextAlignment.left
            self.questionView.backgroundColor = UIColor.white
        case UIInterfaceOrientation.landscapeLeft, UIInterfaceOrientation.landscapeRight:
            self.questionFirstPartLabel.textAlignment = NSTextAlignment.center
            self.questionSecondPartLabel.textAlignment = NSTextAlignment.center
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
        for (index, button) in self.buttonsArray.enumerated() {
            button.backgroundColor = colorsArray[index]
            button.setTitle(textsArray[index], for: UIControlState())
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
        self.buttonsArray[0].transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.1, animations: {
            self.buttonsArray[0].transform = CGAffineTransform(scaleX: 1, y: 1)
            self.buttonsArray[1].transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { (true) in
            UIView.animate(withDuration: 0.1, animations: {
                self.buttonsArray[1].transform = CGAffineTransform(scaleX: 1, y: 1)
                self.buttonsArray[2].transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.buttonsArray[2].transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.buttonsArray[3].transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                        }, completion: { (true) in
                            UIView.animate(withDuration: 0.1, animations: {
                                self.buttonsArray[3].transform = CGAffineTransform(scaleX: 1, y: 1)
                            })
                    })
            })
        }) 
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
        self.scoreView.isHidden = false
        self.updateHighScore()
    }
    
    func updateHighScore() {
        
        let newEntry = LeaderBoardEntry(name: "No_Name", score: self.score, level: self.level)
        
        var data = LeaderBoardEntry.getLeaderboardData()
            
            for (index, leaderBoardEntry) in data.enumerated() {
                if newEntry.score >= leaderBoardEntry.score  {
                    data.insert(newEntry, at: index)
                    break
                }
            }
            
            if data.count > 5 {
                data.removeSubrange(5..<data.count)
            }
            
            LeaderBoardEntry.setLeaderboardData(data)
    }
    
    @IBAction func restartGame() {
        self.resetValues()
        self.randomise()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.updateTime), userInfo: nil, repeats: true)
        self.scoreView.isHidden = true
        self.pauseView.isHidden = true
    }
    
    
    @IBAction func colorButtonTapped(_ button: UIButton) {
        switch self.questionFirstPartLabel.text! {
        case "COLOR":
            if button.backgroundColor!.isEqual(gameColors[self.questionSecondPartLabel.text!]) {
                self.randomise()
            } else {
                self.stopGame()
            }
            
            case "TEXT":
                if button.title(for: UIControlState())! == self.questionSecondPartLabel.text {
                    self.randomise()
                } else {
                    self.stopGame()
            }
            
        default:
            self.stopGame()
        }
    }
}

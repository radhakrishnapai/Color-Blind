//
//  LeaderBoard.swift
//  Color Blind
//
//  Created by qbuser on 17/06/16.
//  Copyright © 2016 Pai. All rights reserved.
//

import UIKit
import Darwin

class LeaderBoardViewController: UIViewController {
    
    @IBOutlet var nameLabelCollection: [UILabel]!
    @IBOutlet var scoreLabelCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateLeaderboard()
    }
    
    func populateLeaderboard() {

        let data = LeaderBoardEntry.getLeaderboardData()
            
            for (index, leaderBoardEntry) in data.enumerated() {
                self.nameLabelCollection[index].text = "\(leaderBoardEntry.name)"
                self.scoreLabelCollection[index].text = "\(leaderBoardEntry.score)"
            }
    }
}

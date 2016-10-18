//
//  LeaderBoardEntry.swift
//  Color Blind
//
//  Created by qbuser on 22/06/16.
//  Copyright © 2016 Pai. All rights reserved.
//

import Foundation

class LeaderBoardEntry: NSObject, NSCoding {
    var name:String
    var score:Int
    var level:Int
    
    init(name:String, score:Int, level:Int) {
        self.name = name
        self.score = score
        self.level = level
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        self.init(name: "",score: 0,level: 1)
        
        if aDecoder.decodeObject(forKey: "name") != nil {
            name = aDecoder.decodeObject(forKey: "name") as! String
        } else {
            name = "No_Name"
        }
        score = aDecoder.decodeInteger(forKey: "score")
        level = aDecoder.decodeInteger(forKey: "level")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encodeConditionalObject(self.name, forKey: "name")
        aCoder.encode(self.score, forKey: "score")
        aCoder.encode(self.level, forKey: "level")
    }
    
    class func getLeaderboardData() -> [LeaderBoardEntry] {
        
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: getleaderBoardFilePath()) as? [LeaderBoardEntry]
        else {
            return [LeaderBoardEntry(name:"No_Name", score:0, level:1)]
        }
        return data
    }
    
    class func getleaderBoardFilePath() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let documentsURL = URL(fileURLWithPath: path)
        let filePath = documentsURL.appendingPathComponent("Leaderboard").path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            return filePath
        } else {
            NSKeyedArchiver.archiveRootObject([LeaderBoardEntry(name: "No_Name", score: 0, level: 1)], toFile:filePath)
            print("FILE NOT AVAILABLE")
        }
        return documentsURL.appendingPathComponent("").path
    }
    
    class func setLeaderboardData(_ leaderboardArray:[LeaderBoardEntry]) {
        NSKeyedArchiver.archiveRootObject(leaderboardArray, toFile: getleaderBoardFilePath())
    }
}

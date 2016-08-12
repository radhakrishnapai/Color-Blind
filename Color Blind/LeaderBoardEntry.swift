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
        
        if aDecoder.decodeObjectForKey("name") != nil {
            name = aDecoder.decodeObjectForKey("name") as! String
        } else {
            name = "No_Name"
        }
        score = aDecoder.decodeIntegerForKey("score")
        level = aDecoder.decodeIntegerForKey("level")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeConditionalObject(self.name, forKey: "name")
        aCoder.encodeInteger(self.score, forKey: "score")
        aCoder.encodeInteger(self.level, forKey: "level")
    }
    
    class func getLeaderboardData() -> [LeaderBoardEntry] {
        
        guard let data = NSKeyedUnarchiver.unarchiveObjectWithFile(getleaderBoardFilePath()) as? [LeaderBoardEntry]
        else {
            return [LeaderBoardEntry(name:"No_Name", score:0, level:1)]
        }
        return data
    }
    
    class func getleaderBoardFilePath() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let documentsURL = NSURL(fileURLWithPath: path)
        let filePath = documentsURL.URLByAppendingPathComponent("Leaderboard").path!
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(filePath) {
            return filePath
        } else {
            NSKeyedArchiver.archiveRootObject([LeaderBoardEntry(name: "No_Name", score: 0, level: 1)], toFile:filePath)
            print("FILE NOT AVAILABLE")
        }
        return documentsURL.URLByAppendingPathComponent("").path!
    }
    
    class func setLeaderboardData(leaderboardArray:[LeaderBoardEntry]) {
        NSKeyedArchiver.archiveRootObject(leaderboardArray, toFile: getleaderBoardFilePath())
    }
}
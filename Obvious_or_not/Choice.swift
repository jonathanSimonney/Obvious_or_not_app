//
//  Choice.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 26/11/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import Foundation

class Choice: NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(summary, forKey: "summary")
        aCoder.encode(voteNumber, forKey: "voteNumber")
        aCoder.encode(percentage, forKey: "percentage")
        aCoder.encode(hasVoted, forKey: "hasVoted")
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String ?? "faked id"
        summary = aDecoder.decodeObject(forKey: "summary") as? String ?? "fake title"
        voteNumber = aDecoder.decodeInteger(forKey: "voteNumber")
        percentage = aDecoder.decodeFloat(forKey: "percentage")
        hasVoted = aDecoder.decodeBool(forKey: "hasVoted")
    }
    
    //text, voteNumber, hasVoted, id
    var id: String
    var summary: String
    var voteNumber: Int
    var percentage: Float
    var hasVoted: Bool
    
    init(id: String, summary: String, voteNumber: Int, percentage: Float, hasVoted: Bool){
        self.id = id
        self.summary = summary
        self.voteNumber = voteNumber
        self.percentage = percentage
        self.hasVoted = hasVoted
        super.init()
    }
}

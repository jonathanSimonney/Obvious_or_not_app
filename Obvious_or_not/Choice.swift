//
//  Choice.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 26/11/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import Foundation

class Choice{
    //text, voteNumber, hasVoted, id
    var id: String
    var description: String
    var voteNumber: Int
    var percentage: Float
    var hasVoted: Bool
    
    init(id: String, description: String, voteNumber: Int, percentage: Float, hasVoted: Bool){
        self.id = id
        self.description = description
        self.voteNumber = voteNumber
        self.percentage = percentage
        self.hasVoted = hasVoted
    }
}

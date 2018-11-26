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
    var id: Int
    var description: String
    var voteNumber: Int
    var hasVoted: Bool
    
    init(id: Int, description: String, voteNumber: Int, hasVoted: Bool){
        self.id = id
        self.description = description
        self.voteNumber = voteNumber
        self.hasVoted = hasVoted
    }
}

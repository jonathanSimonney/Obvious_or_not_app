//
//  Poll.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 23/11/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import Foundation

class Poll {
    var id: Int
    var title: String
    var category: String
    var content: String
    var explanation: String
    var choices: [Choice]
    var totalVotes: Int
    var hasVoted: Bool
    
    init(id: Int, title: String, category: String, content: String, explanation: String, choices: [Choice], totalVotes: Int, hasVoted: Bool){
        self.id = id
        self.title = title
        self.category = category
        self.content = content
        self.explanation = explanation
        self.choices = choices
        self.totalVotes = totalVotes
        self.hasVoted = hasVoted
    }
}

//load the array of polls, to be changed to use alamofire
func getArrayPolls(completionHandler: @escaping (Array<Poll>) -> ()) {
    let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
    
    concurrentQueue.async(execute: {
        sleep(4)
        completionHandler([Poll(id: 1, title: "un titre joli", category: "subjectif", content: "contenu intéressant", explanation: "explication", choices: [Choice(id: 1, description: "oui", voteNumber: 10, hasVoted: false), Choice(id: 2, description: "non", voteNumber: 100, hasVoted: false)], totalVotes: 110, hasVoted: false)
            , Poll(id: 2, title: "swift ou kotlin", category: "langage", content: "contenu plus intéressant", explanation: "un doit être développé avec un mac et l'autre pas.", choices: [Choice(id: 1, description: "swift", voteNumber: 1000, hasVoted: true), Choice(id: 2, description: "kotlin", voteNumber: 100, hasVoted: false)], totalVotes: 1100, hasVoted: true)])
    })
}

//
//  Poll.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 23/11/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Poll {
    var id: String
    var title: String
    var content: String
    var explanation: String
    var choices: [Choice]
    var totalVotes: Int
    var hasVoted: Bool
    
    init(id: String, title: String, content: String, explanation: String, choices: [Choice], totalVotes: Int, hasVoted: Bool){
        self.id = id
        self.title = title
        self.content = content
        self.explanation = explanation
        self.choices = choices
        self.totalVotes = totalVotes
        self.hasVoted = hasVoted
    }
}

func getPollsFromJson(response: DataResponse<Any>) -> [Poll]{
    var pollArray: [Poll] = []
    
    let json = JSON(response.result.value as Any)
    for (_,jsonPoll) in json["data"]{
        var choiceArray: [Choice] = []
        
        for (_,jsonChoice) in jsonPoll["options"]{
            choiceArray.append(Choice(id: jsonChoice["_id"].stringValue, description: jsonChoice["text"].stringValue, voteNumber: jsonChoice["voteNumber"].intValue, percentage: jsonChoice["percentage"].floatValue, hasVoted: jsonChoice["hasVoted"].boolValue))
        }
        
        pollArray.append(Poll(id: jsonPoll["_id"].stringValue, title: jsonPoll["title"].stringValue, content: jsonPoll["content"].stringValue, explanation: jsonPoll["explanation"].stringValue, choices: choiceArray, totalVotes: jsonPoll["totalVotes"].intValue, hasVoted: jsonPoll["hasVoted"].boolValue))
    }
    
    return pollArray
}

//load the array of polls, to be changed to use alamofire
func getArrayPolls(completionHandler: @escaping (Array<Poll>) -> ()) {
    let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
    
    concurrentQueue.async(execute: {
        Alamofire.request("https://obvious-or-not-api.herokuapp.com/survey").responseJSON { response in
            completionHandler(getPollsFromJson(response: response))
        }
    })
}

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

class Poll: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(explanation, forKey: "explanation")
        aCoder.encode(choices, forKey: "choices")
        aCoder.encode(totalVotes, forKey: "totalVotes")
        aCoder.encode(hasVoted, forKey: "hasVoted")
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String ?? "faked id"
        title = aDecoder.decodeObject(forKey: "title") as? String ?? "fake title"
        content = aDecoder.decodeObject(forKey: "content") as? String ?? "fake content"
        explanation = aDecoder.decodeObject(forKey: "explanation") as? String ?? "fake explanation"
        choices = aDecoder.decodeObject(forKey: "choices") as? [Choice] ?? []
        totalVotes = aDecoder.decodeInteger(forKey: "totalVotes")
        hasVoted = aDecoder.decodeBool(forKey: "hasVoted")
    }
    
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
        super.init()
    }
}

func getPollsFromJson(response: DataResponse<Any>) -> [Poll]{
    var pollArray: [Poll] = []
    
    let json = JSON(response.result.value as Any)
    for (_,jsonPoll) in json["data"]{
        var choiceArray: [Choice] = []
        
        for (_,jsonChoice) in jsonPoll["options"]{
            choiceArray.append(Choice(id: jsonChoice["_id"].stringValue, summary: jsonChoice["text"].stringValue, voteNumber: jsonChoice["voteNumber"].intValue, percentage: jsonChoice["percentage"].floatValue, hasVoted: jsonChoice["hasVoted"].boolValue))
        }
        
        pollArray.append(Poll(id: jsonPoll["_id"].stringValue, title: jsonPoll["title"].stringValue, content: jsonPoll["content"].stringValue, explanation: jsonPoll["explanation"].stringValue, choices: choiceArray, totalVotes: jsonPoll["totalVotes"].intValue, hasVoted: jsonPoll["hasVoted"].boolValue))
    }
    
    return pollArray
}

//load the array of polls, to be changed to use alamofire
func getArrayPolls(completionHandler: @escaping (Array<Poll>) -> ()) {
    let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
    
    let potToken = UserDefaults.standard.string(forKey: "userToken")
    var headers: HTTPHeaders
    
    if (potToken != nil) {
        headers = [
            "x-access-token": potToken!
        ]
    } else {
        headers = [
            "stuff": "xx"
        ]
    }
    
    concurrentQueue.async(execute: {
        Alamofire.request("https://obvious-or-not-api.herokuapp.com/survey", headers: headers).responseJSON { response in
            completionHandler(getPollsFromJson(response: response))
        }
    })
}

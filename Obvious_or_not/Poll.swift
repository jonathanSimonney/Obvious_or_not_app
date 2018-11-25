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
    
    init(id: Int, title: String, category: String){
        self.id = id
        self.title = title
        self.category = category
    }
}

//load the array of polls, to be changed to use alamofire
func getArrayPolls(completionHandler: (Array<Poll>) -> ()) {
    
    completionHandler([Poll(id: 1, title: "un titre joli", category: "subjectif")
        , Poll(id: 2, title: "swift ou kotlin", category: "langage")])
    
    
}

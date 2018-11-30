//
//  PollController.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 27/11/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import UIKit

class PollController: UIViewController {

    var poll: Poll?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let unwrappedPoll = self.poll ?? Poll(id: "default id", title: "this poll doesn't exist", content: "false content, please report this as a bug", explanation: "something wrong happened", choices: [], totalVotes: 0, hasVoted: false)

        // Do any additional setup after loading the view.
        let titleView = UILabel()
        titleView.text = unwrappedPoll.title
        
        let contentView = UILabel()
        contentView.text = unwrappedPoll.content
        contentView.numberOfLines = 0

        let explanationView = UILabel()
        explanationView.text = unwrappedPoll.explanation
        explanationView.numberOfLines = 0
        
        let totalVotesView = UILabel()
        totalVotesView.text =  String(unwrappedPoll.totalVotes) + " votes"
        
        let choiceContainer = UIView()
        let numberChoice = unwrappedPoll.choices.count
        
        self.view.addSubviewGrid(titleView, grid: [0, 4, 1, 5], collNumber: 1, rowNumber: 40)
        self.view.addSubviewGrid(contentView, grid: [0, 7, 1, 10], collNumber: 1, rowNumber: 40)
        self.view.addSubviewGrid(explanationView, grid: [0, 11, 1, 14], collNumber: 1, rowNumber: 40)
        self.view.addSubviewGrid(choiceContainer, grid: [0, 15, 1, 16 + numberChoice], collNumber: 1, rowNumber: 40)
        self.view.addSubviewGrid(totalVotesView, grid: [0, 17 + numberChoice, 1, 18 + numberChoice], collNumber: 1, rowNumber: 40)
        
        for (index, choice) in unwrappedPoll.choices.enumerated(){
            let choiceView = UILabel()
            choiceView.text = choice.description + String(choice.percentage)
            
            choiceContainer.addSubviewGrid(choiceView, grid: [0, index, 1, index + 1], collNumber: 1, rowNumber: numberChoice)
        }
    }
    
    func setPoll(poll: Poll){
        self.poll = poll
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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
    var titleView = UILabel()
    var contentView = UILabel()
    var explanationView = UILabel()
    var totalVotesView = UILabel()
    var choiceWithPercentContainer = UIView()
    var choiceWithoutPercentContainer = UIView()
    let startingTag = 100
    var choicesId: [String] = [String]()
    var allChoicesWithPercent: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let unwrappedPoll = self.poll ?? Poll(id: "default id", title: "this poll doesn't exist", content: "false content, please report this as a bug", explanation: "something wrong happened", choices: [], totalVotes: 0, hasVoted: false)

        // Do any additional setup after loading the view.
        titleView.text = unwrappedPoll.title
        
        contentView.text = unwrappedPoll.content
        contentView.numberOfLines = 0

        explanationView.text = unwrappedPoll.explanation
        explanationView.numberOfLines = 0
        
        totalVotesView.text =  String(unwrappedPoll.totalVotes) + " votes"
        
        let numberChoice = unwrappedPoll.choices.count
        
        self.view.addSubviewGrid(titleView, grid: [0, 4, 1, 5], collNumber: 1, rowNumber: 40)
        self.view.addSubviewGrid(contentView, grid: [0, 7, 1, 10], collNumber: 1, rowNumber: 40)
        self.view.addSubviewGrid(choiceWithPercentContainer, grid: [0, 11, 1, 12 + numberChoice], collNumber: 1, rowNumber: 40)
        self.view.addSubviewGrid(choiceWithoutPercentContainer, grid: [0, 11, 1, 12 + numberChoice], collNumber: 1, rowNumber: 40)
        self.view.addSubviewGrid(totalVotesView, grid: [0, 13 + numberChoice, 1, 14 + numberChoice], collNumber: 1, rowNumber: 40)
        self.view.addSubviewGrid(explanationView, grid: [0, 15 + numberChoice, 1, 18 + numberChoice], collNumber: 1, rowNumber: 40)
        
        for (index, choice) in unwrappedPoll.choices.enumerated(){
            let choiceViewWithPercent = UILabel()
            choiceViewWithPercent.text = choice.summary
            choiceViewWithPercent.text = choice.summary + " " + choice.percentage.description + "%"
            
            self.allChoicesWithPercent.append(choiceViewWithPercent)
            
            choiceWithPercentContainer.addSubviewGrid(choiceViewWithPercent, grid: [0, index, 1, index + 1], collNumber: 1, rowNumber: numberChoice)
            
            let choiceViewWithoutPercent = UILabel()
            choiceViewWithoutPercent.text = choice.description
            choiceViewWithoutPercent.text = choice.description
            
            //adding the touch listener for choiceView without percentage
            let tap = UITapGestureRecognizer(target: self, action: #selector(vote))
            choiceViewWithoutPercent.isUserInteractionEnabled = true
            choiceViewWithoutPercent.addGestureRecognizer(tap)
            choiceViewWithoutPercent.tag = startingTag + index
            choicesId.append(choice.id)
            
            choiceWithoutPercentContainer.addSubviewGrid(choiceViewWithoutPercent, grid: [0, index, 1, index + 1], collNumber: 1, rowNumber: numberChoice)
        }
        
        if self.shouldShowUnvotedPart(){
            self.revealUnvotedPart()
        }else{
            self.hideUnvotedPart()
        }
    }
    
    @objc func vote(sender:UITapGestureRecognizer){
        self.voteOnChoiceWith(id: choicesId[sender.view!.tag - startingTag])
    }
    
    func voteOnChoiceWith(id: String){
        fatalError("this method should be overridden in loggedIn and loggedOut pollController")
    }
    
    func shouldShowUnvotedPart() -> Bool{
        fatalError("this method should be overridden in loggedIn and loggedOut pollController")
    }
    
    func hideUnvotedPart(){
        self.explanationView.isHidden = true
        self.totalVotesView.isHidden = true
        self.choiceWithPercentContainer.isHidden = true
        self.choiceWithoutPercentContainer.isHidden = false
    }
    
    func revealUnvotedPart(){
        self.totalVotesView.text =  String(self.poll!.totalVotes) + " votes"
        
        for (index, choice) in (self.poll?.choices.enumerated())!{
            let choiceToChange = self.allChoicesWithPercent[index]
            choiceToChange.text = choice.description + " " + choice.percentage.description + "%"
        }

        self.explanationView.isHidden = false
        self.totalVotesView.isHidden = false
        self.choiceWithPercentContainer.isHidden = false
        self.choiceWithoutPercentContainer.isHidden = true
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

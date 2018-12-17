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
        let underlineAttribute = [kCTUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let underlineAttributedString = NSAttributedString(string: unwrappedPoll.title, attributes: underlineAttribute as [NSAttributedStringKey : Any])
        titleView.attributedText = underlineAttributedString
        
        titleView.textAlignment = .center
        titleView.font = titleView.font.withSize(20)
        
        contentView.text = unwrappedPoll.content
        contentView.numberOfLines = 0

        explanationView.text = unwrappedPoll.explanation
        explanationView.numberOfLines = 0
        
        totalVotesView.text =  String(unwrappedPoll.totalVotes) + " votes"
        totalVotesView.textAlignment = .center
        
        let numberChoice = unwrappedPoll.choices.count
        
        self.view.addSubviewGrid(titleView, grid: [0, 4, 1, 7], collNumber: 1, rowNumber: 40)
        self.view.addSubviewGrid(contentView, grid: [2, 7, 38, 15], collNumber: 40, rowNumber: 40)
        self.view.addSubviewGrid(choiceWithPercentContainer, grid: [2, 16, 38, 17 + numberChoice], collNumber: 40, rowNumber: 40)
        self.view.addSubviewGrid(choiceWithoutPercentContainer, grid: [2, 16, 38, 17 + numberChoice], collNumber: 40, rowNumber: 40)
        self.view.addSubviewGrid(totalVotesView, grid: [0, 18 + numberChoice, 1, 19 + numberChoice], collNumber: 1, rowNumber: 40)
        self.view.addSubviewGrid(explanationView, grid: [2, 20 + numberChoice, 38, 28 + numberChoice], collNumber: 40, rowNumber: 40)
        
        for (index, choice) in unwrappedPoll.choices.enumerated(){
            let choiceViewWithPercent = UILabel()
            choiceViewWithPercent.text = choice.summary + " " + choice.percentage.description + "%"
            
            let backgroundGrey = UILabel()
            backgroundGrey.backgroundColor = UIColor(red:0.74, green:0.76, blue:0.76, alpha:1.0)
            backgroundGrey.layer.cornerRadius = 5
            backgroundGrey.layer.masksToBounds = true
            
            self.allChoicesWithPercent.append(choiceViewWithPercent)
            
            let labelPercent = UILabel()
            labelPercent.backgroundColor = UIColor(red:0.68, green:0.85, blue:0.90, alpha:1.0)
            labelPercent.layer.cornerRadius = 5
            labelPercent.layer.masksToBounds = true
            
            choiceWithPercentContainer.addSubviewGrid(backgroundGrey, grid: [0, index, 1, index + 1], collNumber: 1, rowNumber: numberChoice)
            
            choiceWithPercentContainer.addSubviewGrid(labelPercent, grid: [0, index, Int(choice.percentage), index + 1], collNumber: 100, rowNumber: numberChoice)
        
           choiceWithPercentContainer.addSubviewGrid(choiceViewWithPercent, grid: [0, index, 1, index + 1], collNumber: 1, rowNumber: numberChoice)
            
            let choiceViewWithoutPercent = UILabel()
            choiceViewWithoutPercent.text = choice.summary
            
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
            choiceToChange.text = choice.summary + " " + choice.percentage.description + "%"
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

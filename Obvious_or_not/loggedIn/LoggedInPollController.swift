//
//  LoggedInPollController.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 11/12/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Reachability

class LoggedInPollController: PollController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldShowUnvotedPart() -> Bool{
        if !(self.poll?.hasVoted ?? false){
            return false
        }
        return true
    }

    override func voteOnChoiceWith(id: String){
        
        let reachability = Reachability()
        
        if reachability!.connection != .none{
            let headers: HTTPHeaders = [
                "x-access-token": UserDefaults.standard.string(forKey: "userToken")!
            ]
            
            Alamofire.request("https://obvious-or-not-api.herokuapp.com/survey/" + id, method: .post, headers: headers).responseJSON { response in
                //completionHandler(getPollsFromJson(response: response))
                let jsonResponse = JSON(response.result.value as Any)
                
                if jsonResponse["status"] == 200{
                    getArrayPolls(completionHandler: { polls in
                        if let foo = polls.first(where: {$0.id == self.poll?.id}) {
                            self.setPoll(poll: foo)
                            self.revealUnvotedPart()
                            self.updateCurrentPollInCache()
                            self.showAllChoices()
                        } else {
                            self.showErrors(errors: ["There was an error updating the poll, please refresh the app"])
                        }
                    })
                }else{
                    self.showErrors(errors: [jsonResponse["error"].stringValue])
                }
            }
        }else{
            AlertHelper.displaySimpleAlert(title: "connection required", message: "looks like you're currently not connected to the net. Please try again when you are to vote on a poll.", type: .warning)
        }
    }
    
    private func updateCurrentPollInCache(){        
        var myPolls = ArchiveUtil.loadPolls()
        // create it from scratch then store in the cache
        for (index, poll) in myPolls.enumerated(){
            if poll.id == self.poll?.id{
                myPolls[index] = self.poll!
                break
            }
        }
        
        print(myPolls[0].hasVoted)
        ArchiveUtil.savePolls(polls: myPolls)
    }
    
    private func showErrors(errors: [String]){
        var errorString = ""
        
        for singleError in errors{
            errorString += singleError + "\n"
        }
        
        AlertHelper.displaySimpleAlert(title: "error", message: errorString, type: .error)
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

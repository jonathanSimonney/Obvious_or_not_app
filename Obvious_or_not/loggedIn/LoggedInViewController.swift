//
//  LoggedInViewController.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 11/12/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import UIKit

class LoggedInViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func getPollController() -> PollController{
        return LoggedInPollController()
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

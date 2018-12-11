//
//  LoggedInViewController.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 11/12/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import UIKit

class LoggedOutViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("logged out view controller loaded")
    }
    
    override func getPollController() -> PollController{
        print("function override called")
        return LoggedOutPollController()
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

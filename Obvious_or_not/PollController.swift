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

        // Do any additional setup after loading the view.
        let titleView = UILabel()
        titleView.text = self.poll?.title
        self.view.addSubviewGrid(titleView, grid: [0, 0, 1, 1], collNumber: 1, rowNumber: 4)
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

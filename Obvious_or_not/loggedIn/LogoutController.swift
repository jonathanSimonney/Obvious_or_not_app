//
//  LogoutController.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 11/12/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import UIKit

class LogoutController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Override point for customization after application launch.
        let cache = UserDefaults.standard
        cache.removeObject(forKey: "userToken")
        self.showRightStoryboard()
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

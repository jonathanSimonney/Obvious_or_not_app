//
//  StoryboardHelper.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 11/12/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showRightStoryboard(){
        let cache = UserDefaults.standard
        let isUserLoggedIn = (cache.string(forKey: "userToken") != nil) as Bool
        var storyboardPath :String
        var storyboardControllerId :String
        
        print(isUserLoggedIn)
        print("method called")
        
        if isUserLoggedIn{
            storyboardPath = "LoggedIn"
            storyboardControllerId = "loggedInMainController"
        }else{
            storyboardPath = "Main"
            storyboardControllerId = "loggedOutMainController"
        }
        
        let storyboard = UIStoryboard(name: storyboardPath, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardControllerId) as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
}


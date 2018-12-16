//
//  PollArchiver.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 16/12/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import Foundation

class ArchiveUtil {
    
    private static let PollKey = "pollKey"
    
    private static func archivePolls(polls : [Poll]) -> NSData {
        return NSKeyedArchiver.archivedData(withRootObject: polls as NSArray) as NSData
    }
    
    static func loadPolls() -> [Poll] {
        
        if let unarchivedObject = UserDefaults.standard.object(forKey: PollKey) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [Poll] ?? []
        }
        
        return []
    }
    
    static func savePolls(polls : [Poll]) {
        let archivedObject = archivePolls(polls: polls)
        
        UserDefaults.standard.set(archivedObject, forKey: PollKey)
        UserDefaults.standard.synchronize()
    }
    
}

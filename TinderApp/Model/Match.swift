//
//  Match.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 11/01/21.
//

import UIKit

struct Match {
    let name: String
    let profileImageUrl: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
    
}

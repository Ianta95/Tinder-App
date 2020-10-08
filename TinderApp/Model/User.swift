//
//  User.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 30/09/20.
//

import Foundation
import UIKit

struct User {
    var name: String
    var age: Int
    let email: String
    let uid: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["fullname"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["imageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        
     }
    
}

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
    var imageURLs: [String]
    
    var bio: String
    var profession: String
    var minSeekingAge: Int = 18
    var maxSeekingAge: Int = 60
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["fullname"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.email = dictionary["email"] as? String ?? ""
        self.imageURLs = dictionary["imageURLs"] as? [String] ?? [String]()
        self.uid = dictionary["uid"] as? String ?? ""
        self.bio = dictionary["bio"] as? String ?? ""
        self.profession = dictionary["profession"] as? String ?? ""
        self.minSeekingAge = dictionary["minSeekingAge"] as? Int ?? 18
        self.maxSeekingAge = dictionary["maxSeekingAge"] as? Int ?? 60
     }
    
}

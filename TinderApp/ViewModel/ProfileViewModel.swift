//
//  ProfileViewModel.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 17/12/20.
//

import UIKit

struct ProfileViewModel {
    private let user: User
    var imageCount: Int {
        return user.imageURLs.count
    }
    
    init(user: User) {
        self.user = user
        
    }
}

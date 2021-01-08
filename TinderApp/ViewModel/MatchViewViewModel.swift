//
//  MatchViewViewModel.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 07/01/21.
//

import Foundation

struct MatchViewViewModel {
    private let currentUser: User
    let matchedUser: User
    
    let matchLabelText: String
    
    var currentUserImageURL: URL?
    var matchedUserImageURL: URL?
    
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        
        matchLabelText = "Tu y \(matchedUser.name) han hecho match!"
        guard let currentUserUrlString = currentUser.imageURLs.first else { return }
        guard let matchedUserUrlString = matchedUser.imageURLs.first else { return }
        
        currentUserImageURL = URL(string: currentUserUrlString)
        matchedUserImageURL = URL(string: matchedUserUrlString)
    }
    
}

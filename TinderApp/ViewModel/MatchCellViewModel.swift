//
//  MatchCellViewModel.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 11/01/21.
//

import Foundation

struct MatchCellViewModel {
    
    let nameText: String
    var profileImageUrl: URL?
    let uid: String
    
    init(match: Match) {
        nameText = match.name
        profileImageUrl = URL(string: match.profileImageUrl)
        uid = match.uid
        
    }
    
}

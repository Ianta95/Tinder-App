//
//  MatchView.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 05/01/21.
//

import Foundation
import UIKit

class MatchView: UIView {
    private let currentUser: User
    private let matchedUser: User
    
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        super.init(frame: .zero)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no se implemento en MatchView")
    }
}

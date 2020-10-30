//
//  CardViewModel.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 30/09/20.
//

import Foundation
import UIKit

class CardViewModel {
    let user: User
    let imageURLs: [String]
    let userInfoText: NSAttributedString
    private var imageIndex = 0
    let imageUrl: URL?
    
    init(user: User) {
        self.user = user
        let attributedText = NSMutableAttributedString(string: user.name,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 32,
                                                                                             weight: .heavy),
                                                                    .foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "\t\(user.age)",
                                                 attributes: [.font: UIFont.systemFont(ofSize: 24),
                                                              .foregroundColor: UIColor.white]))
        self.userInfoText = attributedText
        //self.imageUrl = URL(string: user.profileImageUrl)
        self.imageURLs = user.imageURLs
        self.imageUrl = URL(string: self.imageURLs[0])
    }
    
    func showNextPhoto(){
        /*guard imageIndex < user.images.count - 1 else { return }
        self.imageIndex += 1
        self.imageToShow = user.images[imageIndex]*/
    }
    
    func showPreviousPhoto(){
        /*guard imageIndex > 0 else { return }
        self.imageIndex -= 1
        self.imageToShow = user.images[imageIndex]*/
    }
    
    
}

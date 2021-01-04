//
//  ProfileViewModel.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 17/12/20.
//

import UIKit

struct ProfileViewModel {
    /*------> Propiedades <------*/
    private let user: User
    let profession: String
    let bio: String
    var imageCount: Int {
        return user.imageURLs.count
    }
    var imageURLS: [URL] {
        return user.imageURLs.map({ URL(string: $0)!})
    }
    
    /*------> Componentes <------*/
    let userDetailsAttributedString: NSAttributedString
    
    init(user: User) {
        self.user = user
        let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .semibold)])
        attributedText.append(NSAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 22)]))
        userDetailsAttributedString = attributedText
        profession = user.profession
        bio = user.bio
    }
}

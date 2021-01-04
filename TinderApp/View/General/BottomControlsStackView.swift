//
//  BottomControlsStackView.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 28/09/20.
//

import UIKit

class BottomControlsStackView: UIStackView {
    
    let refreshButton = UIButton(type: .system)
    let dislikeButton = UIButton(type: .system)
    let superLikeButton = UIButton(type: .system)
    let likeButton = UIButton(type: .system)
    let boostButton = UIButton(type: .system)
    
    /*------> Life cycle <------*/
    init(refresh: Bool = true, dislike: Bool = true, superLike: Bool = true, like: Bool = true, boost: Bool = true) {
        super.init(frame: .zero)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        distribution = .fillEqually
        
        var buttons = [UIButton]()
        if (refresh) {
            refreshButton.setImage(#imageLiteral(resourceName: "refresh_circle").withRenderingMode(.alwaysOriginal), for: .normal)
            buttons.append(refreshButton)
            adjustImage(button: refreshButton)
        }
        if (dislike) {
            dislikeButton.setImage(#imageLiteral(resourceName: "dismiss_circle").withRenderingMode(.alwaysOriginal), for: .normal)
            buttons.append(dislikeButton)
            adjustImage(button: dislikeButton)
        }
        if (superLike) {
            superLikeButton.setImage(#imageLiteral(resourceName: "super_like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
            buttons.append(superLikeButton)
            adjustImage(button: superLikeButton)
        }
        if (like) {
            likeButton.setImage(#imageLiteral(resourceName: "like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
            buttons.append(likeButton)
            adjustImage(button: likeButton)
        }
        if (boost) {
            boostButton.setImage(#imageLiteral(resourceName: "boost_circle").withRenderingMode(.alwaysOriginal), for: .normal)
            buttons.append(boostButton)
            adjustImage(button: boostButton)
        }
        // Settings
        buttons.forEach { view in
            addArrangedSubview(view)
        }
        
        layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12 )
        
    }
    
    private func adjustImage(button: UIButton) {
        button.imageView!.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder: xxxx) has not been implemented")
    }
}

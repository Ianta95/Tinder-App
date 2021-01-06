//
//  BottomControlsStackView.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 28/09/20.
//

import UIKit

protocol BottomControlsStackViewDelegate: class {
    func handleRefresh()
    func handleDislike()
    func handleSuperLike()
    func handleLike()
    func handleBoost()
    
}

class BottomControlsStackView: UIStackView {
    
    /*------> Componentes <------*/
    let refreshButton = UIButton(type: .system)
    let dislikeButton = UIButton(type: .system)
    let superLikeButton = UIButton(type: .system)
    let likeButton = UIButton(type: .system)
    let boostButton = UIButton(type: .system)
    
    /*------> Variables <------*/
    weak var delegate: BottomControlsStackViewDelegate?
    
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
            refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        }
        if (dislike) {
            dislikeButton.setImage(#imageLiteral(resourceName: "dismiss_circle").withRenderingMode(.alwaysOriginal), for: .normal)
            buttons.append(dislikeButton)
            adjustImage(button: dislikeButton)
            dislikeButton.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
        }
        if (superLike) {
            superLikeButton.setImage(#imageLiteral(resourceName: "super_like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
            buttons.append(superLikeButton)
            adjustImage(button: superLikeButton)
            superLikeButton.addTarget(self, action: #selector(handleSuperlike), for: .touchUpInside)
        }
        if (like) {
            likeButton.setImage(#imageLiteral(resourceName: "like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
            buttons.append(likeButton)
            adjustImage(button: likeButton)
            likeButton.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
        }
        if (boost) {
            boostButton.setImage(#imageLiteral(resourceName: "boost_circle").withRenderingMode(.alwaysOriginal), for: .normal)
            buttons.append(boostButton)
            adjustImage(button: boostButton)
            boostButton.addTarget(self, action: #selector(handleBoostButton), for: .touchUpInside)
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
    
    /*-------> Actions <------*/
    // Refresh
    @objc func handleRefresh() {
        delegate?.handleRefresh()
    }
    // dislike
    @objc func handleDislike() {
        delegate?.handleDislike()
    }
    // superlike
    @objc func handleSuperlike() {
        delegate?.handleSuperLike()
    }
    // likebutton
    @objc func handleLikeButton() {
        delegate?.handleLike()
    }
    // boostbutton
    @objc func handleBoostButton() {
        delegate?.handleBoost()
    }
}

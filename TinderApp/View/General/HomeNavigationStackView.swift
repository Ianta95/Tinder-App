//
//  HomeNavigationStackView.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 28/09/20.
//

import UIKit

// Protocol Navigation
protocol HomeNavigationStackViewDelegate: class {
    func showSettings()
    func showMessages()
     
}

class HomeNavigationStackView: UIStackView {
    /*------> Componentes <------*/
    let settingButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let tinderIcon = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    /*------> Variables <------*/
    weak var delegate: HomeNavigationStackViewDelegate?
    
    /*------> Life cycle <------*/
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        tinderIcon.contentMode = .scaleAspectFit
        settingButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
        
        // Settings
        [settingButton, UIView(), tinderIcon, UIView(), messageButton].forEach { view in
            addArrangedSubview(view)
        }
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        // Activar onClicks
        settingButton.addTarget(self, action: #selector(handleShowSettings), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(handleShowMessages), for: .touchUpInside)
    }
    
    /*------> Actions <------*/
    // Muestra Settings
    @objc func handleShowSettings() {
        delegate?.showSettings()
    }
    // Muestra Mensajes
    @objc func handleShowMessages() {
        delegate?.showMessages()
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder: xxxx) has not been implemented")
    }
}

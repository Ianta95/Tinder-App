//
//  SettingsFooter.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 29/10/20.
//

import UIKit

protocol SettingsFooterDelegate: class {
    func settingsLogout()
}

class SettingsFooter: UIView {
    /*------> Componentes <------*/
    private lazy var logoutButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Logout", for: .normal)
        btn.setTitleColor(.systemRed, for: .normal)
        btn.backgroundColor = .gray
        btn.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return btn
    }()
    
    /*------> Variables <------*/
    weak var delegate: SettingsFooterDelegate?
    
    /*------> Overrides <------*/
    override init(frame: CGRect) {
        super.init(frame: frame)
        let spacer = UIView()
        addSubview(spacer)
        spacer.setDimensions(height: 32, width: frame.width)
        addSubview(logoutButton)
        logoutButton.anchor(top: spacer.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 60)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no se implemento con exito")
    }
    
    /*------> Actions <------*/
    @objc func handleLogout() {
        delegate?.settingsLogout()
    }
    
}


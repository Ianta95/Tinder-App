//
//  CustomTextFieldAuth.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 02/10/20.
//

import UIKit
class CustomAuthTextField: UITextField {
    init(placeholder: String, secureTextEntry: Bool = false) {
        super.init(frame: .zero)
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 14)
        leftView = spacer
        leftViewMode = .always
        keyboardAppearance = .dark
        borderStyle = .none
        textColor = .white
        backgroundColor = UIColor(white: 1, alpha: 0.2)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        layer.cornerRadius = 5
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        isSecureTextEntry = secureTextEntry
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) de CustomTextFieldAuth fallo")
    }
}

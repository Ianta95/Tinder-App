//
//  CustomAuthTextButton.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 02/10/20.
//

import UIKit

class CustomAuthTextButton: UIButton {
    init(lightText: String, heavyText: String, fontSize:CGFloat = 18) {
        super.init(frame: .zero)
        let attributtedTitle = NSMutableAttributedString(string: lightText, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: fontSize)])
        attributtedTitle.append(NSAttributedString(string: heavyText, attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: fontSize)]))
        self.setAttributedTitle(attributtedTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) fallo en CustomAuthTextButton")
    }
}

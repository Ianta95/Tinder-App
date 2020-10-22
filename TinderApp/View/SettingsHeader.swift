//
//  SettingsHeader.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 20/10/20.
//

import UIKit

protocol SettingsHeaderDelegate: class {
    func settingsHeader(_ header: SettingsHeader, didSelect index: Int )
}

class SettingsHeader: UIView {
    /*------> Componentes <------*/
    lazy var button1 = createButton(0)
    lazy var button2 = createButton(1)
    lazy var button3 = createButton(2)
    var buttons = [UIButton]()
    /*------> Propiedades <------*/
    weak var delegate: SettingsHeaderDelegate?
    
    /*------> Preparacion App <------*/
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) Ha fallado al iniciar Settings Header")
    }
    
    /*------> Acciones <------*/
    @objc func handleSelectPhoto(sender: UIButton){
        print("show photo selected")
        delegate?.settingsHeader(self, didSelect: sender.tag)
    }
    
    /*------> Otras funciones <------*/
    
    private func configureButtons(){
        //backgroundColor = .cyan
        buttons.append(button1)
        buttons.append(button2)
        buttons.append(button3)
        addSubview(button1)
        button1.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16)
        button1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.55).isActive = true
        let stack = UIStackView(arrangedSubviews: [button2, button3] )
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        addSubview(stack)
        stack.anchor(top: topAnchor, left: button1.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
    }
    
    private func createButton(_ index: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Seleccionar foto", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.tag = index
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
}

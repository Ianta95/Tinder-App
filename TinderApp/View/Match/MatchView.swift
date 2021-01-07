//
//  MatchView.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 05/01/21.
//

import Foundation
import UIKit

class MatchView: UIView {
    /*------> Propiedades <------*/
    private let currentUser: User
    private let matchedUser: User
    
    /*------> Componentes <------*/
    // Imagen match
    private let matchImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "itsamatch"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    // Label de descripcion
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "Tu y X han hecho match"
        return label
    }()
    // Imagen del usuario
    private let currentUserImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "lady4c"))
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    // Imagen del match
    private let matchUserImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "lady4c"))
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    // Boton para mandar mensaje
    private let sendMessageButton: UIButton = {
        let button = SendMessageButton(type: .system)
        button.setTitle("Mandar mensaje", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSendMessage), for: .touchUpInside)
        return button
    }()
    // Boton para seguir en swipes
    private let keepSwipingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Seguir buscando", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapKeepSwiping), for: .touchUpInside)
        return button
    }()
    // Imagen con efecto visual
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    lazy var views = [
        matchImageView,
        descriptionLabel,
        currentUserImageView,
        matchUserImageView,
        sendMessageButton,
        keepSwipingButton
    ]
    
    /*------> Ciclo App <------*/
    // Init
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        super.init(frame: .zero)
        configureBlurView()
        configureUI()
    }
    // Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no se implemento en MatchView")
    }
    
    /*------> Acciones <------*/
    // Click mandar mensaje
    @objc func didTapSendMessage(){
        
    }
    // Click seguir buscando
    @objc func didTapKeepSwiping(){
        
    }
    // Click pantalla borrosa
    @objc func handleDismissal(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    /*------> Preparativos App <------*/
    // Configurar UI
    func configureUI(){
        views.forEach { view in
            addSubview(view)
            view.alpha = 1
        }
        // Configurar imagen perfil
        currentUserImageView.anchor(left: centerXAnchor, paddingLeft: 16)
        currentUserImageView.setDimensions(height: 140, width: 140)
        currentUserImageView.layer.cornerRadius = 140 / 2
        currentUserImageView.centerY(inView: self)
        // Configurar imagen del match
        matchUserImageView.anchor(right: centerXAnchor, paddingRight: 16)
        matchUserImageView.setDimensions(height: 140, width: 140)
        matchUserImageView.layer.cornerRadius = 140 / 2
        matchUserImageView.centerY(inView: self)
        // Configurar los botones
        sendMessageButton.anchor(top: currentUserImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 32, paddingLeft: 48, paddingRight: 48)
        sendMeesageButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        keepSwipingButton.anchor(top: sendMessageButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 32, paddingLeft: 48, paddingRight: 48)
        descriptionLabel.anchor(left: leftAnchor, bottom: currentUserImageView.topAnchor, right: rightAnchor, paddingBottom: 32)
        
        matchImageView.anchor(bottom: descriptionLabel.topAnchor)
        matchImageView.setDimensions(height: 80, width: 300)
        matchImageView.centerX(inView: self)
    }
    // Configurar efecto borroso
    func configureBlurView(){
        print("Inicia configure blur view")
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        visualEffectView.addGestureRecognizer(tap)
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        visualEffectView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.visualEffectView.alpha = 1
        }, completion: nil)
    }
}
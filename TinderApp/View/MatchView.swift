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
    private let matchedUser: User+
    
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
        let button = UIButton(type: .system)
        button.setTitle("Mandar mensaje", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSendMessage), for: .touchUpInside)
        return button
    }
    // Boton para seguir en swipes
    private let keepSwipingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Seguir buscando", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapKeepSwiping), for: .touchUpInside)
        return button
    }
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
    }
    // Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no se implemento en MatchView")
    }
    
    /*------> Acciones <------*/
    // Boton mandar mensaje
    @objc func didTapSendMessage(){
        
    }
    //Boton seguir buscando
    @objc func didTapKeepSwiping(){
        
    }
    
    /*------> Preparativos App <------*/
    // Configurar UI
    func configureUI(){
        views.forEach { view in
            addSubview(view)
            view.alpha = 0
        }
        
        matchImageView.anchor()
    }
    // Configurar efecto borroso
    func configureBlurView(){
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        visualEffectView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.visualEffectView.alpha = 1
        } completion: nil)

    }
}

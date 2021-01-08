//
//  MatchView.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 05/01/21.
//

import Foundation
import UIKit

protocol MatchViewDelegate: class {
    func matchView(_ view: MatchView, wantsToSendMessageTo user: User)
}

class MatchView: UIView {
    /*------> Propiedades <------*/
    private let viewModel: MatchViewViewModel
    weak var delegate: MatchViewDelegate?
    
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
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    // Imagen del match
    private let matchUserImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "lady4c"))
        iv.contentMode = .scaleAspectFill
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
        let button = KeepSwipingButton(type: .system)
        button.setTitle("Seguir buscando", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
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
    init(viewModel: MatchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        loadUserData()
        configureBlurView()
        configureUI()
        configureAnimations()
    }
    // Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no se implemento en MatchView")
    }
    
    /*------> Acciones <------*/
    // Click mandar mensaje
    @objc func didTapSendMessage(){
        delegate?.matchView(self, wantsToSendMessageTo: viewModel.matchedUser)
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
    // Cargar informacion
    func loadUserData() {
        descriptionLabel.text = viewModel.matchLabelText
        currentUserImageView.sd_setImage(with: viewModel.currentUserImageURL)
        matchUserImageView.sd_setImage(with: viewModel.matchedUserImageURL)
    }
    // Configurar UI
    func configureUI(){
        views.forEach { view in
            addSubview(view)
            view.alpha = 0
        }
        // Configurar imagen perfil
        currentUserImageView.anchor(right: centerXAnchor, paddingRight: 16)
        currentUserImageView.setDimensions(height: 140, width: 140)
        currentUserImageView.layer.cornerRadius = 140 / 2
        currentUserImageView.centerY(inView: self)
        // Configurar imagen del match
        matchUserImageView.anchor(left: centerXAnchor, paddingLeft: 16)
        matchUserImageView.setDimensions(height: 140, width: 140)
        matchUserImageView.layer.cornerRadius = 140 / 2
        matchUserImageView.centerY(inView: self)
        // Configurar los botones
        sendMessageButton.anchor(top: currentUserImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 32, paddingLeft: 48, paddingRight: 48)
        sendMessageButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        keepSwipingButton.anchor(top: sendMessageButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 32, paddingLeft: 48, paddingRight: 48)
        keepSwipingButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        descriptionLabel.anchor(left: leftAnchor, bottom: currentUserImageView.topAnchor, right: rightAnchor, paddingBottom: 32)
        
        matchImageView.anchor(bottom: descriptionLabel.topAnchor)
        matchImageView.setDimensions(height: 80, width: 300)
        matchImageView.centerX(inView: self)
    }
    // Prepara animaciones de match view
    func configureAnimations() {
        views.forEach({ $0.alpha = 1})
        let angle = 30 * CGFloat.pi / 180
        currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle).concatenating(CGAffineTransform(translationX: 200, y: 0))
        matchUserImageView.transform = CGAffineTransform(rotationAngle: angle).concatenating(CGAffineTransform(translationX: -200, y: 0))
        
        self.sendMessageButton.transform = CGAffineTransform(translationX: -500, y: 0)
        self.keepSwipingButton.transform = CGAffineTransform(translationX: 500, y: 0)
        
        UIView.animateKeyframes(withDuration: 1.3, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45) {
                self.currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
                self.matchUserImageView.transform = CGAffineTransform(rotationAngle: angle )
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.45) {
                self.currentUserImageView.transform = .identity
                self.matchUserImageView.transform = .identity
            }
        }, completion: nil)
        
        UIView.animate(withDuration: 0.75, delay: 0.5*1.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.sendMessageButton.transform = .identity
            self.keepSwipingButton.transform = .identity
        }, completion: nil)
        
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

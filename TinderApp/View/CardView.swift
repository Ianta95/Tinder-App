//
//  CardView.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 28/09/20.
//

import UIKit
import SDWebImage


protocol CardViewDelegate: class {
    func cardview(_ view: CardView, showProfileFor user: User)
}

class CardView: UIView {
    /*------> Componentes <------*/
    // Photo image
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = #imageLiteral(resourceName: "lady4c")
        return img
    }()
    // Info text
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.attributedText = viewModel.userInfoText
        return label
    }()
    // Info button
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleShowProfile), for: .touchUpInside)
        return button
    }()
    // Bar Stack View
    private let barStackView = UIStackView()
    
    /*------> Variables <-------*/
    // Gradient background
    private let gradientLayer = CAGradientLayer()
    // View Model
    private let viewModel: CardViewModel
    // Delegate
    weak var delegate: CardViewDelegate?
    
    /*------> Overrides <------*/
    
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureGestureRecognizers()
        imageView.sd_setImage(with: viewModel.imageUrl)
        
        layer.cornerRadius = 10
        clipsToBounds = true
        addSubview(imageView)
        imageView.fillSuperview()
        configureBarStackView()
        configureGradientLayer()
        addSubview(infoLabel)
        infoLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        addSubview(infoButton)
        infoButton.setDimensions(height: 40, width: 40)
        infoButton.centerY(inView: infoLabel)
        infoButton.anchor(right: rightAnchor, paddingRight: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) from CardView has not been implemented")
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    /*------> Preparativos Card view <------*/
    // Configura gradient layer
    func configureGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    // Configura barstackView
    func configureBarStackView() {
        (0..<viewModel.imageURLs.count).forEach { _ in
            let barView = UIView()
            barView.backgroundColor = .barDeselectedColor
            barStackView.addArrangedSubview(barView)
        }
        
        barStackView.arrangedSubviews.first?.backgroundColor = .white
        addSubview(barStackView)
        barStackView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8, height: 4)
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
    }
    
    
}

extension CardView {
    
    private func configureGestureRecognizers(){
        print("Inicia configure Gesture Recognizers")
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
    }
    /*------> Actions <------*/
    // Pan gesture
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
            break
        case .changed:
            swipeCard(sender: sender)
            break
        case .ended:
            resetCardPosition(sender: sender)
        default:
            break
        }
    }
    // Cambiar foto
    @objc func handleChangePhoto(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: nil).x
        let shouldShowNextPhoto = location > self.frame.width / 2
        if shouldShowNextPhoto {
            viewModel.showNextPhoto()
        } else {
            viewModel.showPreviousPhoto()
        }
        imageView.sd_setImage(with: viewModel.imageUrl)
        barStackView.arrangedSubviews.forEach({ $0.backgroundColor = .barDeselectedColor})
        barStackView.arrangedSubviews[viewModel.index].backgroundColor = .white
    }
    
    @objc func handleShowProfile(){
        delegate?.cardview(self, showProfileFor: viewModel.user)
    }
    
    /*------> Otras funciones <------*/
    func swipeCard(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    func resetCardPosition(sender: UIPanGestureRecognizer){
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        UIView.animate(withDuration: 0.80, delay: 0,usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            if shouldDismissCard {
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
                self.alpha = 0.3
            } else {
                self.transform = .identity
            }
        } completion: { complete in
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }

    }
    

    
}

//
//  CardView.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 28/09/20.
//

import UIKit

class CardView: UIView {
    // Photo image
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = #imageLiteral(resourceName: "lady4c")
        return img
    }()
    // Gradient background
    private let gradientLayer = CAGradientLayer()
    // Info text
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "Pepe Sola",
                                                       attributes: [.font: UIFont.systemFont(ofSize: 32,
                                                                                             weight: .heavy),
                                                                    .foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "\t20",
                                                 attributes: [.font: UIFont.systemFont(ofSize: 24),
                                                              .foregroundColor: UIColor.white]))
        label.attributedText = attributedText
        return label
    }()
    // Info button
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        clipsToBounds = true
        addSubview(imageView)
        imageView.fillSuperview()
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
    
    func configureGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
}

//
//  MatchCell.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 07/01/21.
//

import UIKit

class MatchCell: UICollectionViewCell {
    /*------> Componentes <------*/
    // Imagen perfil
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "kelly2"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.setDimensions(height: 80, width: 80)
        imageView.layer.cornerRadius = 80/2
        return imageView
    }()
    // Nombre usuario
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Usuario"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    /*------> Propiedades <------*/
    var viewModel: MatchCellViewModel! {
        didSet {
            usernameLabel.text = viewModel.nameText
            profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        }
    }
    
    /*------> Ciclo vida <------*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Añadir views
        let stack = UIStackView(arrangedSubviews: [profileImageView, usernameLabel])
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6
        addSubview(stack)
        stack.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) fallo al implementarse en Match Cell")
    }
}

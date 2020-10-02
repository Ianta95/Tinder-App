//
//  LoginController.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 02/10/20.
//

import UIKit

class LoginController: UIViewController {
    /*------> Propiedades <------*/
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        img.tintColor = .white
        return img
    }()
    private let emailTextField = CustomAuthTextField(placeholder: "Email")
    private let passwordTextField = CustomAuthTextField(placeholder: "Password", secureTextEntry: true)
    private let authButton: CustomAuthButton = {
        let button = CustomAuthButton(title: "Inicio Sesión", type: .system)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    private let goToRegistrationButton: UIButton = {
        let button = CustomAuthTextButton(lightText: "¿Aun no tienes cuenta? ", heavyText: "Registrate")
        button.addTarget(self, action: #selector(handleShowRegistration), for: .touchUpInside)
        return button
    }()
    /*------> Overrides <------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    /*------> Acciones <------*/
    @objc func handleLogin(){
        
    }
    
    @objc func handleShowRegistration(){
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    /*------> Configuracion App <------*/
    func configureUI(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 80, width: 80)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 40)
        // Stack texfields
        let stackTextFields = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, authButton])
        stackTextFields.axis = .vertical
        stackTextFields.spacing = 16
        view.addSubview(stackTextFields)
        stackTextFields.centerY(inView: view)
        stackTextFields.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 30, paddingRight: 30)
        // Bottom button
        view.addSubview(goToRegistrationButton)
        goToRegistrationButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingBottom: 10, paddingRight: 32)
        
    }
    
}

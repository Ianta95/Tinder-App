//
//  RegistrationController.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 02/10/20.
//

import UIKit

class RegistrationController: UIViewController {
    
    /*------> Propiedades <------*/
    private let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    private let fullNameTextField = CustomAuthTextField(placeholder: "Nombre Completo")
    private let emailTextField = CustomAuthTextField(placeholder: "Email")
    private let passwordTextField = CustomAuthTextField(placeholder: "Password", secureTextEntry: true)
    private let authButton: CustomAuthButton = {
        let button = CustomAuthButton(title: "Registrarme", type: .system)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    private let goToLoginButton: UIButton = {
        let button = CustomAuthTextButton(lightText: "¿Ya tienes una cuenta? ", heavyText: "Iniciar sesión")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    /*------> Overrides <------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    /*------> Acciones <------*/
    @objc func handleSelectPhoto(){
        
    }
    @objc func handleRegister(){
        
    }
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    /*------> Configuracion App <------*/
    func configureUI(){
        configureGradientLayer()
        // Add photo button
        view.addSubview(selectPhotoButton)
        selectPhotoButton.setDimensions(height: 240, width: 240)
        selectPhotoButton.centerX(inView: view)
        selectPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        // Stack texfields
        let stackTextFields = UIStackView(arrangedSubviews: [fullNameTextField,emailTextField, passwordTextField, authButton])
        stackTextFields.axis = .vertical
        stackTextFields.spacing = 16
        view.addSubview(stackTextFields)
        stackTextFields.anchor(top:selectPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingRight: 30)
        // Bottom button
        view.addSubview(goToLoginButton)
        goToLoginButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingBottom: 10, paddingRight: 32)
        
    }
    
    
}

//
//  LoginController.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 02/10/20.
//

import UIKit

class LoginController: UIViewController {
    /*------> Propiedades <------*/
    // Components
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
    // Variables
    private var viewModel = LoginViewModel()
    /*------> Overrides <------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextObservers()
        configureUI()
    }
    
    /*------> Acciones <------*/
    @objc func handleLogin(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        AuthService.loginUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Error al intentar hacer login: \(error.localizedDescription)")
                return
            }
            print("DEBUG: Se logro hacer login correctamente")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleShowRegistration(){
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    /*------> Configuracion App <------*/
    // Configura UI
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
    // Configure observers
    func configureTextObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    // Checa si es valido
    func checkFormStatus(){
        if viewModel.formIsValid {
            authButton.isEnabled = true
            authButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        } else {
            authButton.isEnabled = false
            authButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        }
    }
}

extension LoginController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

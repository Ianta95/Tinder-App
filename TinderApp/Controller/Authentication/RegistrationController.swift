//
//  RegistrationController.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 02/10/20.
//

import UIKit

class RegistrationController: UIViewController {
    
    /*------> Propiedades <------*/
    // Components
    private let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
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
    // Variables
    private var viewModel = RegistrationViewModel()
    
    /*------> Overrides <------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextObservers()
        configureUI()
    }
    
    /*------> Acciones <------*/
    @objc func handleSelectPhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    @objc func handleRegister(){
        
    }
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    // Cambio de texto
    @objc func textDidChange(sender: UITextField){
        switch sender {
        case fullNameTextField:
            viewModel.name = sender.text
            break
        case emailTextField:
            viewModel.email = sender.text
            break
        case passwordTextField:
            viewModel.password = sender.text
            break
        default:
            break
        }
        checkFormStatus()
    }
    
    /*------> Configuracion App <------*/
    // Configura UI
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
    // Configura observers
    func configureTextObservers() {
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
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

/*------> Delegates <------*/
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        selectPhotoButton.layer.borderWidth = 3
        selectPhotoButton.layer.cornerRadius = 10
        selectPhotoButton.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
    
}

extension RegistrationController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fullNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

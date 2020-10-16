//
//  HomeController.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 28/09/20.
//

import UIKit
import Firebase

class HomeController: UIViewController {

    private let topStack = HomeNavigationStackView()
    private let bottomStack = BottomControlsStackView()
    
    private var viewModels = [CardViewModel]() {
        didSet { configureCards() }
    }
    
    private let deckView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
        configureUI()
        fetchUsers()
    }
    
    /*------> API <------*/
    // Fetch data
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { user in
            print("DEBUG: se ejecuto el completion")
        }
    }
    
    // Fetch all users
    func fetchUsers() {
        Service.fetchUsers { users in
            print("DEBUG: Usuarios son \(users)")
            self.viewModels = users.map({ CardViewModel(user: $0) })
            
        }
    }
    
    // Checa status usuario
    func checkIfUserLoggedIn(){
        if Auth.auth().currentUser == nil {
            presentLoginController()
        } else {
            
        }
    }
    // Cierra sesión
    func logout() {
        do {
            try Auth.auth().signOut()
            print("DEBUG: Presenta login controller aqui")
            presentLoginController()
        } catch {
            print("DEBUG: Error al intentar cerrar sesión")
        }
    }
    /*------> Preparativos App <------*/
    // Configura Tarjetas
    func configureCards(){
        viewModels.forEach { (viewModel) in
            let cardView = CardView(viewModel: viewModel)
            deckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        print("DEBUG: Configura las tarjetas")
        
    }
    
    // Configura Interfaz
    func configureUI(){
        view.backgroundColor = .white
        topStack.delegate = self
        let stack = UIStackView(arrangedSubviews: [topStack, deckView, bottomStack])
        stack.axis = .vertical
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor ,right: view.rightAnchor)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView )
    }
    
    /*------> Navigations <------*/
    private func presentLoginController() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
}

/*------> Extensions <------*/
// Navegacion de StackView
extension HomeController: HomeNavigationStackViewDelegate {
    func showSettings() {
        print("Click en settings")
    }
    
    func showMessages() {
        print("Click en Mensajes")
    }
    
    
}

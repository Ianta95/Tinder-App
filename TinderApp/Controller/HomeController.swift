//
//  HomeController.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 28/09/20.
//

import UIKit

class HomeController: UIViewController {

    private let topStack = HomeNavigationStackView()
    private let bottomStack = BottomControlsStackView()
    private let deckView: UIView = {
        let view = UIView()
        //view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 5
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCards()
    }
    
    func configureCards(){
        let user1 = User(name: "Jane Doe", age: 23, images: [#imageLiteral(resourceName: "jane1"), #imageLiteral(resourceName: "jane2")])
        let user2 = User(name: "Meghan", age: 26, images: [#imageLiteral(resourceName: "lady5c"), #imageLiteral(resourceName: "kelly1")])
        
        let cardView1 = CardView(viewModel: CardViewModel(user: user1))
        let cardView2 = CardView(viewModel: CardViewModel(user: user2))
        
        
        
        deckView.addSubview(cardView1)
        deckView.addSubview(cardView2)
        cardView1.fillSuperview()
        cardView2.fillSuperview()
    }
    
    func configureUI(){
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [topStack, deckView, bottomStack])
        stack.axis = .vertical
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor ,right: view.rightAnchor)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView )
    }
    
}

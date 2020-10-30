//
//  ProfileController.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 29/10/20.
//

import UIKit

class ProfileController: UIViewController {
    
    /*------> Variables <------*/
    private let user: User
    
    /*------> Override <------*/
    // Init
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    // Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) en ProfileController no se inicio de manera correcta")
    }
    
    // View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

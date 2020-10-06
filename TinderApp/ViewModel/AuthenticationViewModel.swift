//
//  AuthenticationViewModel.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 06/10/20.
//

import Foundation

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false
    }
}

struct RegistrationViewModel: AuthenticationViewModel {
    var name: String?
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false &&
            name?.isEmpty == false
    }
}

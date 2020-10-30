//
//  Enums.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 29/09/20.
//

import Foundation

enum SwipeDirection: Int {
    case left = -1
    case right = 1
}

enum SettingsSections: Int, CaseIterable {
    case name
    case profession
    case age
    case bio
    case ageRange
    
    var description: String {
        switch self {

        case .name: return "Nombre"
        case .profession: return "Profesion"
        case .age: return "Edad"
        case .bio: return "Biografía"
        case .ageRange: return "Rango de edad"
        }
    }
}

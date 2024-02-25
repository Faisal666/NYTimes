//
//  AuthFormCellTypes.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import Foundation
import UIKit

enum AuthFormCellTypes {
    case email
    case name
    case nationalID
    case phoneNumber
    case date
    case password
    case actionButton(title: String)

    var keyboardType: UIKeyboardType {
        switch self {
        case .name:
            return .default
        case .password:
            return .default
        case .date:
            return .numbersAndPunctuation
        case .email:
            return .emailAddress
        case .nationalID:
            return .numberPad
        case .phoneNumber:
            return .phonePad
        default:
            return .default
        }
    }

    var isSecureTextEntry: Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }

    var placeholder: String {
        switch self {
        case .name:
            "Enter your name"
        case .password:
            "Enter your password"
        case .date:
            "Enter your birth date"
        case .email:
            "Enter your email address"
        case .nationalID:
            "Enter your nationalID"
        case .phoneNumber:
            "Enter your phone number"
        default:
            String()
        }
    }

    var title: String {
        switch self {
        case .name:
            "Name"
        case .password:
            "Password:"
        case .date:
            "Birthdate:"
        case .email:
            "Email address:"
        case .nationalID:
            "nationalID:"
        case .phoneNumber:
            "Phone number:"
        default:
            String()
        }
    }
}

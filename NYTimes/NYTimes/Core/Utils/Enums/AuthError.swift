//
//  AuthErrors.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import Foundation

enum AuthError: Error {
    case userAlreadyExists
    case userNotFound
    case incorrectPassword
    case unknownError

    var errorMessage: String {
        switch self {
        case .userAlreadyExists:
            "User already exist"
        case .userNotFound:
            "User not found"
        case .incorrectPassword:
            "Password is wrong"
        case .unknownError:
            "Unkown"
        }
    }
}

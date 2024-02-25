//
//  AuthenticationViewModel.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import Foundation

class AuthenticationViewModel {
    enum ViewState {
        case signIn
        case signUp
    }

    var onAuthStateChanged: ((ViewState) -> Void)?

    var currentState: ViewState = .signIn {
        didSet {
            onAuthStateChanged?(currentState)
        }
    }

    func toggleState() {
        currentState = (currentState == .signIn) ? .signUp : .signIn
    }
}

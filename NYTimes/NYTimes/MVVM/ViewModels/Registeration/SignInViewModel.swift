//
//  SignInViewModel.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import Foundation

class SignInViewModel: BaseAuthFormViewModel {

    override init(userSessionManager: UserSessionManaging = UserSessionManager()) {
        super.init(userSessionManager: userSessionManager)
        cells = [.email, .password, .actionButton(title: "Sign in")]
    }

    func validateForm() {
        let isValid = Validator.validateEmail(email) == .success && Validator.validatePassword(password) == .success
        isActionButtonEnabled = isValid
    }

    override func formUpdated() {
        validateForm()
    }

    func signIn(completion: @escaping (Result<Void, AuthError>) -> Void) {
        userSessionManager.signIn(email: email, password: password, completion: completion)
    }
}

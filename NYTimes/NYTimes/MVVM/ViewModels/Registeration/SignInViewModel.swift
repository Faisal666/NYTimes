//
//  SignInViewModel.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import Foundation

class SignInViewModel: BaseAuthFormViewModel {

    override init() {
        super.init()
        cells = [.email, .password, .actionButton(title: "Sign in")]
    }

    func validateForm() {
        let isValid = Validator.validateEmail(email) == .success && Validator.validatePassword(password) == .success
        isActionButtonEnabled = isValid
    }

    override func formUpdated() {
        validateForm()
    }
}

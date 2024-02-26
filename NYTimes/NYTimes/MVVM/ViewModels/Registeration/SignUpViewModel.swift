//
//  SignUpViewModel.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import Foundation

class SignUpViewModel: BaseAuthFormViewModel {

    override init(userSessionManager: UserSessionManaging = UserSessionManager()) {
        super.init(userSessionManager: userSessionManager)
        cells = [.name, .email, .password, .phoneNumber, .date, .actionButton(title: "Sign Up")]
    }

    func validateForm() {
        let isValid = Validator.validateEmail(email) == .success &&
        Validator.validatePassword(password) == .success &&
        Validator.validateName(name) == .success &&
        Validator.validatePhoneNumber(phoneNumber) == .success && 
        Validator.validateDate(birthDate) == .success
        isActionButtonEnabled = isValid
    }

    override func formUpdated() {
        validateForm()
    }

    func signUp(completion: @escaping (Result<Void, AuthError>) -> Void) {
        userSessionManager.signUp(email: email, name: name, nationalID: nationalId, phoneNumber: phoneNumber, birthdate: birthDate, password: password, completion: completion)
    }
}


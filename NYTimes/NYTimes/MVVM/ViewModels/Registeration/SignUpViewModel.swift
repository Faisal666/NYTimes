//
//  SignUpViewModel.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import Foundation


class SignUpViewModel: BaseAuthFormViewModel {
    override init() {
        super.init()
        cells = [.name, .email, .password, .phoneNumber, .date, .actionButton(title: "Sign Up")]
    }
}


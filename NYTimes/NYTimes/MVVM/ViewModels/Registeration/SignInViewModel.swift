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
}

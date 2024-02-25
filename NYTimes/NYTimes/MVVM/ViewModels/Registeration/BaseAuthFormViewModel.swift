//
//  BaseAuthFormViewModel.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import Foundation

class BaseAuthFormViewModel {

    var email: String = ""
    var password: String = ""
    var phone: String = ""
    

    var cells: [AuthFormCellTypes] = [] {
        didSet {
            needToRefreshTableViewHandler?()
        }
    }

    var isActionButtonEnabled: Bool = false {
        didSet {
            reloadActionButtonHandler?()
        }
    }

    var reloadActionButtonHandler: (() -> Void)?
    var needToRefreshTableViewHandler: (() -> Void)?

    func validate(input: String, forCellType cellType: AuthFormCellTypes) -> Validator.ValidationResult {
        switch cellType {
        case .email:
            Validator.validateEmail(input)
        case .name:
            Validator.validateName(input)
        case .nationalID:
            Validator.validateNationalID(input)
        case .phoneNumber:
            Validator.validatePhoneNumber(input)
        case .password:
            Validator.validatePassword(input)
        default:
            Validator.ValidationResult.success
        }
    }
}

//
//  BaseAuthFormViewModel.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import Foundation
import CryptoKit

class BaseAuthFormViewModel {

    var name: String = ""
    var email: String = ""
    var password: String = ""
    var birthDate: Date? = nil
    var nationalId: String = ""
    var phoneNumber: String = ""
    let userSessionManager: UserSessionManaging

    init(userSessionManager: UserSessionManaging) {
        self.userSessionManager = userSessionManager
    }

    var cells: [AuthFormCellTypes] = [] {
        didSet {
            needToRefreshTableViewHandler?()
        }
    }

    var isActionButtonEnabled: Bool = false {
        didSet {
            reloadActionButtonHandler?(cells.count - 1)
        }
    }

    var reloadActionButtonHandler: ((Int) -> Void)?
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

    func fromUpdated(input: String, forCellType cellType: AuthFormCellTypes) {
        switch cellType {
        case .email:
            email = input
        case .name:
            name = input
        case .nationalID:
            nationalId = input
        case .phoneNumber:
            phoneNumber = input
        case .password:
            password = input
        default:
            break
        }
        formUpdated()
    }

    func formBirthdateUpdated(input: Date) {
        birthDate = input
        formUpdated()
    }

    func hashPassword(_ password: String) -> String {
        let inputData = Data(password.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()

        return hashString
    }

    func formUpdated() { } // Overridden
}

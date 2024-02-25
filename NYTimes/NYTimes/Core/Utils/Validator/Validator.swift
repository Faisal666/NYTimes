//
//  Validator.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import Foundation

class Validator {

    enum ValidationResult {
        case success
        case failure(ValidationError)
    }

    enum ValidationError: Error {
        case emailInvalid
        case nameEmpty
        case nationalIDInvalid
        case phoneNumberInvalid
        case dateInvalid
        case passwordWeak

        var errorMessage: String {
            switch self {
            case .emailInvalid:
                return "Invalid email format"
            case .nameEmpty:
                return "Name cannot be empty"
            case .nationalIDInvalid:
                return "Invalid national ID format"
            case .phoneNumberInvalid:
                return "Invalid phone number format"
            case .dateInvalid:
                return "Please select a birthday date"
            case .passwordWeak:
                return "Password is too weak. Must contain at least 8 characters, including a number and an uppercase letter."
            }
        }
    }

    static func validateEmail(_ email: String) -> ValidationResult {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        if !NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) {
            return .failure(ValidationError.emailInvalid)
        }
        return .success
    }

    static func validateName(_ name: String)  -> ValidationResult {
        if name.isEmpty {
            return .failure(ValidationError.nameEmpty)
        }
        return .success
    }

    static func validateNationalID(_ id: String) -> ValidationResult {
        let idRegex = "^[0-9]{10}$"
        if !NSPredicate(format: "SELF MATCHES %@", idRegex).evaluate(with: id) {
            return .failure(ValidationError.nationalIDInvalid)
        }

        return .success
    }

    static func validatePhoneNumber(_ phone: String) -> ValidationResult {
        let phoneRegex = "^\\d{10}$"
        if !NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone) {
            return .failure(ValidationError.phoneNumberInvalid)
        }

        return .success
    }

    static func validateDate(_ dateString: String) -> ValidationResult {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        if formatter.date(from: dateString) == nil {
            return .failure(ValidationError.dateInvalid)
        }

        return .success
    }

    static func validatePassword(_ password: String) -> ValidationResult {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        if !NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password) {
            return .failure(ValidationError.passwordWeak)
        }
        return .success
    }
}

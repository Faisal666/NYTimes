//
//  UserSessionManager.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import Foundation
import CryptoKit

protocol UserSessionManaging {
    func signIn(email: String, password: String, completion: @escaping (Result<Void, AuthError>) -> Void)
    func signUp(email: String, name: String, nationalID: String, phoneNumber: String, birthdate: Date?, password: String, completion: @escaping (Result<Void, AuthError>) -> Void)
    func logOutUser()
    var currentUser: User? { get }
}

class UserSessionManager: UserSessionManaging {

    private let realmManager: RealmManaging
    private let userDefaults = UserDefaults.standard
    private let currentUserKey = "currentUserEmail"

    init(realmManager: RealmManaging = RealmManager()) {
        self.realmManager = realmManager
    }

    var currentUser: User? {
        guard let email = userDefaults.string(forKey: currentUserKey) else { return nil }
        return realmManager.fetchObjects(User.self).filter("email = %@", email).first
    }

    private func hashPassword(_ password: String) -> String {
        let inputData = Data(password.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()

        return hashString
    }

    func signIn(email: String, password: String, completion: @escaping (Result<Void, AuthError>) -> Void) {
        let hashedPassword = hashPassword(password)
        guard let user = realmManager.fetchObjects(User.self).filter("email = %@", email).first else {
            completion(.failure(.userNotFound))
            return
        }

        if user.password == hashedPassword {
            userDefaults.setValue(email, forKey: currentUserKey)
            completion(.success(()))
        } else {
            completion(.failure(.incorrectPassword))
        }
    }

    func signUp(email: String, name: String, nationalID: String, phoneNumber: String, birthdate: Date?, password: String, completion: @escaping (Result<Void, AuthError>) -> Void) {
        let existingUser = realmManager.fetchObjects(User.self).filter("email = %@", email).first
        if existingUser != nil {
            completion(.failure(.userAlreadyExists))
            return
        }

        let hashedPassword = hashPassword(password)

        let user = User()
        user.email = email
        user.name = name
        user.nationalID = nationalID
        user.phoneNumber = phoneNumber
        if let birthdate {
            user.birthdate = birthdate
        }
        user.password = hashedPassword

        realmManager.addObject(user)
        userDefaults.setValue(email, forKey: currentUserKey)
        completion(.success(()))
    }

    func logOutUser() {
        userDefaults.removeObject(forKey: currentUserKey)
    }
}

//
//  User.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var email: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var nationalID: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var birthdate: Date = Date()
    @objc dynamic var password: String = ""

    override static func primaryKey() -> String? {
        return "email"
    }
}

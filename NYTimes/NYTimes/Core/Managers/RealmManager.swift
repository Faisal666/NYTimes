//
//  RealmManager.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import RealmSwift

protocol RealmManaging {
    func addObject<T: Object>(_ object: T)
    func deleteObject<T: Object>(_ object: T)
    func fetchObjects<T: Object>(_ type: T.Type) -> Results<T>
    func updateObject(_ block: @escaping () -> Void)
    func deleteAllObjects<T: Object>(_ type: T.Type)
    func addObjects<T: Object>(_ object: [T])
}

class RealmManager: RealmManaging {

    private var realm: Realm {
        return try! Realm()
    }

    func addObject<T: Object>(_ object: T) {
        try? realm.write {
            realm.add(object)
        }
    }

    func addObjects<T: Object>(_ object: [T]) {
        try? realm.write {
            realm.add(object)
        }
    }

    func deleteObject<T: Object>(_ object: T) {
        try? realm.write {
            realm.delete(object)
        }
    }

    func deleteAllObjects<T: Object>(_ type: T.Type) {
        try? realm.write {
            realm.delete(realm.objects(type))
        }
    }

    func fetchObjects<T: Object>(_ type: T.Type) -> Results<T> {
        return realm.objects(type)
    }

    func updateObject(_ block: @escaping () -> Void) {
        try? realm.write {
            block()
        }
    }
}

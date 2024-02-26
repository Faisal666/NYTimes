//
//  CachedArticlesManager.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import Foundation

class CachedArticlesManager {

    private let realmManager: RealmManaging

    init(realmManager: RealmManaging = RealmManager()) {
        self.realmManager = realmManager
    }

    func fetchSavedArticles() -> [Article] {
        return Array(realmManager.fetchObjects(Article.self))
    }

    func cacheArticles(articles: [Article]) {
        realmManager.deleteAllObjects(Article.self)
        realmManager.addObjects(articles)
    }
}

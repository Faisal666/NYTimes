//
//  DashboardViewModel.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import Foundation

class DashboardViewModel {

    let apiClient: APIClient
    let cachedArticlesManager: CachedArticlesManager
    var isSearchActive: Bool = false
    var sortAcsending: Bool = false
    var articles: [Article] = [] {
        didSet {
            filteredArticles = articles
        }
    }
    var filteredArticles: [Article] = [] {
        didSet {
            didFetchArticlesHandler?()
        }
    }

    var didFetchArticlesHandler: (() -> Void)?

    init(apiClient: APIClient = APIClient(), cachedArticlesManager: CachedArticlesManager = CachedArticlesManager()) {
        self.apiClient = apiClient
        self.cachedArticlesManager = cachedArticlesManager
    }

    func fetchArticles() {
        APIClient().fetchArticles { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles.results
                self?.cachedArticlesManager.cacheArticles(articles: articles.results)

            case .failure(let error):
                switch error {
                case .requestFailed:
                    self?.articles = self?.cachedArticlesManager.fetchSavedArticles() ?? []
                default:
                    self?.articles = []

                }
            }
        }
    }

    func filterItems(searchQuery: String?) {
        guard let searchQuery = searchQuery, !searchQuery.isEmpty else {
            filteredArticles = articles
            isSearchActive = false
            return
        }

        filteredArticles = articles.filter { item in
            item.title?.lowercased().contains(searchQuery.lowercased()) ?? false
        }

        isSearchActive = true
    }

    func sortByDateString() {
        sortAcsending.toggle()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-dd-mm"

        filteredArticles.sort { first, second in
            guard let firstDate = dateFormatter.date(from: first.publishedDate ?? ""),
                  let secondDate = dateFormatter.date(from: second.publishedDate ?? "") else {
                return false
            }
            return sortAcsending ? firstDate < secondDate : firstDate > secondDate
        }
    }
}

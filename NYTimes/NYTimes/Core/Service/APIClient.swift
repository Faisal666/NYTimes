//
//  APIClient.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import Foundation

class APIClient {
    let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchArticles(completion: @escaping (Result<ArticlesResponse, NetworkError>) -> Void){
        networkService.request(route: APIRouter.fetchMostViewed, completion: completion)
    }
}

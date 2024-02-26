//
//  APIRoute.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import Foundation

enum APIRouter {

    case fetchMostViewed

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .fetchMostViewed:
            return .get
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .fetchMostViewed:
            return "/svc/mostpopular/v2/viewed/30.json"
        }
    }

    private var queryParameters: [URLQueryItem]? {
        switch self {
        case .fetchMostViewed:
            return [URLQueryItem(name: "api-key", value: AppConfiguration().apiKey)]

        default:
            return nil
        }
    }

    private var parameters: [String:String]? {

        switch self {
        default:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: try AppConfiguration().apiBaseURL.asURL().appendingPathComponent(path).absoluteString) //try K.ProductionServer.baseURL.asURL()

        urlComponents?.queryItems = queryParameters
        var urlRequest = URLRequest(url: urlComponents!.url!)

        urlRequest.httpMethod = method.rawValue

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        #if DEBUG
            print(urlRequest.allHTTPHeaderFields!)
        #endif
        if let parameters = parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                urlRequest.httpBody = data
            } catch {
                throw NetworkError.parameterEncodingFailed
            }
        }

        return urlRequest
    }
}

extension String {
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.badURL }

        return url
    }
}

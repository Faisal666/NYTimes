//
//  NetworkService.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

protocol NetworkServiceProtocol {
    func request<T: Decodable>(route: APIRouter, completion: @escaping (Result<T, NetworkError>) -> Void)
}

struct NetworkService: NetworkServiceProtocol {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func request<T: Decodable>(route: APIRouter, completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let request = try route.asURLRequest()
            session.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    DispatchQueue.main.async {
                        completion(.failure(.requestFailed(error!)))
                    }
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidResponse))
                    }
                    return
                }
                data.printJSON()
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedResponse))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError(error)))
                    }
                }
            }.resume()
        } catch {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.badURL))
            }
        }
    }
}

extension Data{
    func printJSON() {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            print(JSONString)
        }
    }
}

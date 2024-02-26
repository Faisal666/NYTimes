//
//  NetworkError.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case parameterEncodingFailed
}

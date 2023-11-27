//
//  APIService.swift
//  Demo Task
//
//  Created by Devasis KC on 26/11/2023.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
}

class APIService {
    
    static func fetchData<T: Decodable>(url: URL) async throws -> T {
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decodableObject = try JSONDecoder().decode(T.self, from: data)
            return decodableObject
        } catch {
            throw APIError.decodingError(error)
        }
    }
}

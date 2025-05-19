//
//  BaseRepository.swift
//  PhotoEase
//
//  Created by Tree Bui Quang Tri on 6/3/25.
//

import Foundation

public class SimpleRepository<T: Codable> {
    public func fetch(
        endpoint: String
    ) async throws -> T? {
        do {
            guard let safeURL = URL(string: endpoint) else { return nil }
            
            var request = URLRequest(url: safeURL, timeoutInterval: 20.0)
            
            request.httpMethod = HTTPMethod.get.rawValue
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            
            let result = try await URLSession.shared.data(for: request)
            
            let response = result.1
            let data = result.0
            
            try handleStatusCode(from: response)
            
            let decodedObject: T = try decode(from: data)
            return decodedObject
        } catch {
            if error is CustomError {
                throw error
            } else {
                throw CustomError.serverError
            }
        }
    }
    
    private func handleStatusCode(from response: URLResponse) throws {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw CustomError.serverError
        }
        
        if statusCode == 500 {
            throw CustomError.serverError
        }
        
        if statusCode < 300 {
            return
        }
    }
    
    private func decode<Obj: Codable>(from data: Data) throws -> Obj {
        do {
            let decodedObject = try JSONDecoder().decode(Obj.self, from: data)
            return decodedObject
        } catch let DecodingError.dataCorrupted(context) {
            throw CustomError.customError("\(context.debugDescription) at \(context.codingPath)")
        } catch let DecodingError.keyNotFound(key, context) {
            throw CustomError.customError("Key '\(key)' not found: \(context.debugDescription) at \(context.codingPath)")
        } catch let DecodingError.valueNotFound(value, context) {
            throw CustomError.customError("Value '\(value)' not found: \(context.debugDescription) at \(context.codingPath)")
        } catch let DecodingError.typeMismatch(type, context)  {
            throw CustomError.customError("Type '\(type)' mismatch: \(context.debugDescription) at \(context.codingPath)")
        } catch {
            throw CustomError.badData
        }
    }
}

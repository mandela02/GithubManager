//
//  String+Extension.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import Foundation

extension String {
    /// Converts a JSON string to an array of ImageModel objects
    /// - Returns: Array of ImageModel objects or nil if conversion fails
    func toImageModelArray() throws -> [UserModel] {
        guard let jsonData = self.data(using: .utf8) else {
            print("Failed to convert string to data")
            return []
        }
        
        let decoder = JSONDecoder()
        
        let imageModels = try decoder.decode([UserModel].self, from: jsonData)
        return imageModels
    }
}

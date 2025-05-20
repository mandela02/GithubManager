//
//  String+Extension.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//

@testable import GithubManager
import XCTest

extension String {
    func toUserModelArray() throws -> [UserModel] {
        guard let data = self.data(using: .utf8) else {
            throw NSError(domain: "ParseError", code: 1, userInfo: nil)
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode([UserModel].self, from: data)
    }
}

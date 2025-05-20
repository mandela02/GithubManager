//
//  Array+Extension.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//

@testable import GithubManager
import XCTest

extension Array where Element == UserModel {
    func toJSONString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let data = try? encoder.encode(self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}

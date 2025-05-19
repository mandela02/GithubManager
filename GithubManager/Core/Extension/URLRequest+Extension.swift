//
//  URLRequest+Extension.swift
//  PhotoEase
//
//  Created by Tree Bui Quang Tri on 6/3/25.
//

import Foundation

extension URLRequest {
    mutating func addData(jsonString: String) {
        guard let jsonData = jsonString.data(using: .utf8) else { return }
        self.httpBody = jsonData
    }
}

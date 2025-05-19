//
//  Data+Extension.swift
//  PhotoEase
//
//  Created by Tree Bui Quang Tri on 6/3/25.
//

import Foundation

extension Data {
    var asString: String? { String(data: self, encoding: .utf8) }
}

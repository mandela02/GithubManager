//
//  Environment.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import SwiftUtilities

public class Environment {
    public init(
        endpoint: String
    ) {
        self.useCaseProvider = UseCaseProvider(endpoint: endpoint)
    }
    
    public var useCaseProvider: UseCaseProvider
}

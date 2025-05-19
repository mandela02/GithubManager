//
//  User.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import Foundation

public struct User: Identifiable {
    public init(
        name: String,
        avatar: String,
        url: String
    ) {
        self.name = name
        self.avatar = avatar
        self.url = url
    }
    
    public let id: String = UUID().uuidString
    
    public let name: String
    public let avatar: String
    public let url: String
}

extension UserModel {
    public func toObject() -> User {
        User(
            name: self.login ?? "",
            avatar: self.avatarURL ?? "",
            url: self.htmlURL ?? ""
        )
    }
}

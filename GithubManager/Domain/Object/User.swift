//
//  User.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import Foundation

public struct User: Identifiable, Equatable {
    public init(
        login: String,
        avatar: String,
        url: String
    ) {
        self.login = login
        self.avatar = avatar
        self.url = url
    }
    
    public let id: String = UUID().uuidString
    
    public let login: String
    public let avatar: String
    public let url: String
}

extension UserModel {
    public func toObject() -> User {
        User(
            login: self.login ?? "",
            avatar: self.avatarURL ?? "",
            url: self.htmlURL ?? ""
        )
    }
}

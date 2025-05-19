//
//  UserDetail.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import Foundation

public struct UserDetail: Identifiable {
    public init(
        login: String,
        name: String,
        avatar: String,
        htmlUrl: String,
        blog: String,
        location: String,
        followers: Int,
        following: Int
    ) {
        self.login = login
        self.name = name
        self.avatar = avatar
        self.htmlUrl = htmlUrl
        self.location = location
        self.followers = followers
        self.following = following
        self.blog = blog
    }
    
    public let id: String = UUID().uuidString
    
    public let login: String
    public let name: String
    public let avatar: String
    public let htmlUrl: String
    public let blog: String
    public let location: String
    public let followers: Int
    public let following: Int
}

extension UserDetailModel {
    public func toObject() -> UserDetail {
        UserDetail(
            login: self.login ?? "",
            name: self.name ?? "",
            avatar: self.avatarUrl ?? "",
            htmlUrl: self.htmlUrl ?? "",
            blog: self.blog ?? "",
            location: self.location ?? "",
            followers: self.followers ?? 0,
            following: self.following ?? 0
        )
    }
}

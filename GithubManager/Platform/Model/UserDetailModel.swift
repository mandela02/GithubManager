//
//  UserDetailModel.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

// MARK: - Welcome
public struct UserDetailModel: Codable {
    public init(
        id: Int? = nil,
        login: String? = nil,
        name: String? = nil,
        avatarUrl: String? = nil,
        htmlUrl: String? = nil,
        blog: String? = nil,
        location: String? = nil,
        followers: Int? = nil,
        following: Int? = nil,
        publicRepos: Int? = nil,
        publicGists: Int? = nil
    ) {
        self.id = id
        self.login = login
        self.name = name
        self.avatarUrl = avatarUrl
        self.htmlUrl = htmlUrl
        self.blog = blog
        self.location = location
        self.followers = followers
        self.following = following
        self.publicRepos = publicRepos
        self.publicGists = publicGists
    }
    
    let id: Int?
    
    let login: String?
    let name: String?
    let avatarUrl: String?
    let htmlUrl: String?
    let blog: String?
    let location: String?
    let followers: Int?
    let following: Int?
    let publicRepos: Int?
    let publicGists: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case blog
        case location
        case followers
        case following
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
    }
}

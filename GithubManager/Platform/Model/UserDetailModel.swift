//
//  UserDetailModel.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

// MARK: - Welcome
public struct UserDetailModel: Codable {
    let id: Int?
    
    let login: String?
    let name: String?
    let avatarUrl: String?
    let htmlUrl: String?
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
        case location
        case followers
        case following
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
    }
}

//
//  UserModel.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

// MARK: - WelcomeElement
public struct UserModel: Codable {
    let login: String?
    let avatarURL: String?
    let htmlURL: String?

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
    }
}

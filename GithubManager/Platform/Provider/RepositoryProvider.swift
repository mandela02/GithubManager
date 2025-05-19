//
//  RepositoryProvider.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

public struct RepositoryProvider {
    public init(endpoint: String) {
        self.apiEndpoint = endpoint
    }
    
    private let apiEndpoint: String

    public lazy var usersRepository = UsersRepository(endpoint: apiEndpoint)
    public lazy var userDetailRepository = UserDetailRepository(endpoint: apiEndpoint)
}

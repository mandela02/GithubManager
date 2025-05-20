//
//  RepositoryProvider.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

/// Provides access to various repositories used in the application, initialized with a common API endpoint.
public class RepositoryProvider {

    /// Initializes the `RepositoryProvider` with the specified API endpoint.
    ///
    /// - Parameter endpoint: The base URL or endpoint used by all repositories.
    public init(endpoint: String) {
        self.apiEndpoint = endpoint
    }
    
    /// The base API endpoint used to initialize all repositories.
    private let apiEndpoint: String

    /// Lazily initialized repository for accessing user list data.
    public lazy var usersRepository = UsersRepository(endpoint: apiEndpoint)

    /// Lazily initialized repository for accessing detailed user information.
    public lazy var userDetailRepository = UserDetailRepository(endpoint: apiEndpoint)
}

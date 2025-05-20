//
//  UseCaseProvider.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//


/// A provider class responsible for creating and supplying use case instances.
/// Uses a `RepositoryProvider` to inject dependencies into the use cases.
public class UseCaseProvider: UseCaseProviderProtocol {

    /// The repository provider that supplies repositories for use cases.
    private let repositoryProvider: RepositoryProvider

    /// Initializes the `UseCaseProvider` with the specified API endpoint.
    ///
    /// - Parameter endpoint: The base URL or endpoint used to initialize repositories.
    public init(
        endpoint: String
    ) {
        self.repositoryProvider = RepositoryProvider(
            endpoint: endpoint
        )
    }

    /// Provides a use case for fetching a single user's detail.
    ///
    /// - Returns: An instance of `GetUserUseCase`.
    public func getUserUseCase() -> GetUserUseCase {
        GetUserUseCase(userDetailRepository: repositoryProvider.userDetailRepository)
    }

    /// Provides a use case for fetching a list of users.
    ///
    /// - Returns: An instance of `GetUsersUseCase`.
    public func getUsersUseCase() -> GetUsersUseCase {
        GetUsersUseCase(usersRepository: repositoryProvider.usersRepository)
    }

    /// Provides a use case for retrieving cached users.
    ///
    /// - Returns: An instance of `GetCachedUsersUseCase`.
    public func getCachedUsersUseCase() -> GetCachedUsersUseCase {
        GetCachedUsersUseCase(usersRepository: repositoryProvider.usersRepository)
    }
}

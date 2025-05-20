//
//  UseCaseProvider.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//


public class UseCaseProvider: UseCaseProviderProtocol {
    private let repositoryProvider: RepositoryProvider
    
    public init(
        endpoint: String
    ) {
        self.repositoryProvider = RepositoryProvider(
            endpoint: endpoint
        )
    }
    
    public func getUserUseCase() -> GetUserUseCase {
        GetUserUseCase(userDetailRepository: repositoryProvider.userDetailRepository)
    }
    
    public func getUsersUseCase() -> GetUsersUseCase {
        GetUsersUseCase(usersRepository: repositoryProvider.usersRepository)
    }
    
    public func getCachedUsersUseCase() -> GetCachedUsersUseCase {
        GetCachedUsersUseCase(usersRepository: repositoryProvider.usersRepository)
    }
}

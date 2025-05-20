//
//  GetCachedUsersUseCase.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

/// A use case responsible for retrieving cached user data from local storage.
public class GetCachedUsersUseCase {

    /// The repository used to access cached user data.
    public let usersRepository: UsersRepository

    /// Initializes the use case with a `UsersRepository`.
    ///
    /// - Parameter usersRepository: The repository used to read cached users.
    public init(
        usersRepository: UsersRepository
    ) {
        self.usersRepository = usersRepository
    }

    /// Represents the input parameters for the use case.
    /// Currently empty, but defined for future extensibility.
    public struct Input {
        public init() {}
    }

    /// Executes the use case to retrieve cached users and convert them to domain models.
    ///
    /// - Returns: An array of `User` domain models.
    /// - Throws: An error if reading from the cache fails.
    public func run() async throws -> [User] {
        let result = try usersRepository.getCachedUser(fileName: Constants.users)
        return result.map { $0.toObject() }
    }
}

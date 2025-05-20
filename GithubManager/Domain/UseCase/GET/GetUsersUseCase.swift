//
//  GetUsersUseCase.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

/// A use case responsible for fetching a paginated list of users from the repository.
public class GetUsersUseCase {

    /// The repository used to fetch user data.
    public let usersRepository: UsersRepository

    /// Initializes the use case with a `UsersRepository`.
    ///
    /// - Parameter usersRepository: The repository used to fetch users.
    public init(
        usersRepository: UsersRepository
    ) {
        self.usersRepository = usersRepository
    }

    /// Input parameters required to execute the use case.
    public struct Input {
        /// The page number to fetch (used for calculating offset).
        let page: Int

        /// The number of users to fetch per page.
        let perPage: Int

        /// Initializes the input with pagination details.
        ///
        /// - Parameters:
        ///   - page: The page number to fetch.
        ///   - perPage: The number of users to retrieve per page.
        public init(
            page: Int,
            perPage: Int
        ) {
            self.page = page
            self.perPage = perPage
        }
    }

    /// Executes the use case to fetch users based on the provided input.
    ///
    /// - Parameter input: The pagination input containing page and per-page count.
    /// - Returns: An array of `User` domain models.
    /// - Throws: An error if fetching users from the repository fails.
    public func run(input: Input) async throws -> [User] {
        let result = try await usersRepository.getUsers(
            perPage: input.perPage,
            since: input.page * input.perPage
        )
        return result.map { $0.toObject() }
    }
}

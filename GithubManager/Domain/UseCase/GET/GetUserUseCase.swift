//
//  GetUserUseCase.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

/// A use case responsible for fetching detailed information about a single user.
public class GetUserUseCase {

    /// The repository used to fetch user detail data.
    public let userDetailRepository: UserDetailRepository

    /// Initializes the use case with a `UserDetailRepository`.
    ///
    /// - Parameter userDetailRepository: The repository used to fetch user details.
    public init(
        userDetailRepository: UserDetailRepository
    ) {
        self.userDetailRepository = userDetailRepository
    }

    /// Input parameters required to execute the use case.
    public struct Input {
        /// The login identifier of the user whose details are to be fetched.
        let login: String

        /// Initializes the input with the user login.
        ///
        /// - Parameter login: The username or login of the user.
        public init(login: String) {
            self.login = login
        }
    }

    /// Executes the use case to fetch detailed user information.
    ///
    /// - Parameter input: The input containing the login identifier.
    /// - Returns: A `UserDetail` domain model.
    /// - Throws: An error if the fetch operation fails.
    public func run(input: Input) async throws -> UserDetail {
        let result = try await userDetailRepository.getUser(login: input.login)
        return result.toObject()
    }
}

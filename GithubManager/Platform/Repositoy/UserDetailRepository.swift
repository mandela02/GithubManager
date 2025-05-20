//
//  UserDetailRepository.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import Foundation
import DataLayer

/// A repository class responsible for fetching user detail data from the API.
/// Inherits from `BaseRepository` with a generic type of `UserDetailModel`.
public class UserDetailRepository: BaseRepository<UserDetailModel> {

    /// Fetches user detail information for the specified login.
    ///
    /// - Parameter login: The username or login identifier used to query the user.
    /// - Returns: A `UserDetailModel` instance containing the user’s details.
    /// - Throws: An error if the network request fails or data decoding fails.
    public func getUser(
        login: String
    ) async throws -> UserDetailModel {
        let data = try await repository.fetchItem(
            path: String(format: Endpoints.user, login),
            param: [:],
            needAuthToken: false
        )
        return data
    }
}

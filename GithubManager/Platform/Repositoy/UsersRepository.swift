//
//  UsersRepository.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import Foundation
import DataLayer

public class UsersRepository: BaseRepository<[UserModel]> {
    public func getUsers(
        perPage: Int,
        since: Int
    ) async throws -> [UserModel] {
        let data = try await repository.fetchItem(
            path: Endpoints.users,
            param: [
                "per_page": perPage,
                "since": since
            ],
            needAuthToken: false
        )
        return data
    }
}

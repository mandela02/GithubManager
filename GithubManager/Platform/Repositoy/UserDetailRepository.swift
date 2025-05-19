//
//  UserDetailRepository.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import Foundation
import DataLayer

public class UserDetailRepository: BaseRepository<UserDetailModel> {
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

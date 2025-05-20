//
//  UsersRepository.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import Foundation
import DataLayer

/// A repository class responsible for fetching and caching a list of users.
/// Inherits from `BaseRepository` with a generic type of `[UserModel]`.
public class UsersRepository: BaseRepository<[UserModel]> {

    /// Fetches a list of users from the API and updates the local cache.
    ///
    /// - Parameters:
    ///   - perPage: The number of users to fetch per request.
    ///   - since: The user ID to start fetching from (for pagination).
    /// - Returns: An array of `UserModel` objects fetched from the API.
    /// - Throws: An error if the network request or file operations fail.
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
        
        var cachedUser = try getCachedUser(fileName: Constants.users)
        
        cachedUser = cachedUser + data
        
        try saveCachedUser(users: cachedUser, fileName: Constants.users)
        
        return data
    }

    /// Retrieves cached users from the local file system.
    ///
    /// - Parameter fileName: The name of the file storing cached user data.
    /// - Returns: An array of `UserModel` loaded from cache.
    /// - Throws: An error if file reading or decoding fails.
    public func getCachedUser(fileName: String) throws -> [UserModel] {
        let string = try readStringFromFile(fileName: fileName)
        return try string?.toUserModelArray() ?? []
    }

    /// Saves the given user data to a local cache file.
    ///
    /// - Parameters:
    ///   - users: The array of users to cache.
    ///   - fileName: The name of the file to save the cache to.
    /// - Throws: An error if writing to the file fails.
    public func saveCachedUser(users: [UserModel], fileName: String) throws {
        let string = users.toJSONString() ?? ""
        return try saveStringToFile(string, fileName: fileName)
    }

    // MARK: - File manages
    // FIXME: - Stop being a lazy ass and use database
    
    /// Saves a string to a file in the app’s document directory.
    ///
    /// - Parameters:
    ///   - string: The string to write to the file.
    ///   - fileName: The name of the file to write to.
    /// - Throws: An error if writing to the file fails.
    public func saveStringToFile(_ string: String, fileName: String) throws {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            return
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        try string.write(to: fileURL, atomically: true, encoding: .utf8)
    }

    /// Reads a string from a file in the app’s document directory.
    /// If the file doesn't exist, it creates an empty JSON array file (`[]`).
    ///
    /// - Parameter fileName: The name of the file to read from.
    /// - Returns: The contents of the file as a string, or `nil` if the file cannot be read.
    /// - Throws: An error if reading from or writing to the file fails.
    public func readStringFromFile(fileName: String) throws -> String? {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            return nil
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)

        if !FileManager.default.fileExists(atPath: fileURL.path) {
            try "[]".write(to: fileURL, atomically: true, encoding: .utf8)
        }

        return try String(contentsOf: fileURL, encoding: .utf8)
    }
}

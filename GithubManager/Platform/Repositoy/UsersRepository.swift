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
        
        var cachedUser = try getCachedUser(fileName: Constants.users)
        
        cachedUser = cachedUser + data
        
        try saveCachedUser(users: cachedUser, fileName: Constants.users)
        
        return data
    }
    
    // FIXME: - I'm too lazy to setup a database
    public func getCachedUser(fileName: String) throws -> [UserModel] {
        let string = try readStringFromFile(fileName: fileName)
        return try string?.toUserModelArray() ?? []
    }
    
    public func saveCachedUser(users: [UserModel], fileName: String) throws {
        let string = users.toJSONString() ?? ""
        
        return try saveStringToFile(string, fileName: fileName)
    }
    
    
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

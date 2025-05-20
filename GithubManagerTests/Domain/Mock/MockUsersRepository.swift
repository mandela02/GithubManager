//
//  MockUsersRepository.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//

import XCTest
@testable import GithubManager

class MockUsersRepository: UsersRepository {
    var mockUsers: [UserModel]?
    
    var since: Int?
    var perPage: Int?
    var shouldDelay = false
    var getUsersCalled = false
    var getUserssCallCount = 0

    var mockCachedUsers: [UserModel]?
    var savedCachedUsers: [UserModel]?
    var savedFileName: String = ""
    var lastRequestedFileName: String = ""
    var shouldThrowError = false

    override func getUsers(perPage: Int, since: Int) async throws -> [UserModel] {
        getUsersCalled = true
        getUserssCallCount += 1
        
        self.since = since
        self.perPage = perPage
        
        if shouldDelay {
            // Simulate network delay
            try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        }
        
        if shouldThrowError {
            throw NSError(domain: "MockRepositoryError", code: 1, userInfo: nil)
        }
        
        return mockUsers ?? []
    }
    
    override func getCachedUser(fileName: String) throws -> [UserModel] {
        lastRequestedFileName = fileName
        
        if shouldThrowError {
            throw NSError(domain: "MockRepositoryError", code: 1, userInfo: nil)
        }
        return mockCachedUsers ?? []
    }
    
    override func saveCachedUser(users: [UserModel], fileName: String) throws {
        if shouldThrowError {
            throw NSError(domain: "MockRepositoryError", code: 2, userInfo: nil)
        }
        savedCachedUsers = users
        savedFileName = fileName
    }
}

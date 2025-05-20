//
//  MockUserDetailRepository.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//

import XCTest
@testable import GithubManager

class MockUserDetailRepository: UserDetailRepository {
    var mockUser: UserDetailModel?
    var login: String?
    var shouldDelay = false
    var getUserCalled = false
    var getUserCallCount = 0

    var shouldThrowError = false
    
    override func getUser(login: String) async throws -> UserDetailModel {
        self.getUserCalled = true
        self.getUserCallCount += 1
        
        self.login = login
        
        if shouldDelay {
            // Simulate network delay
            try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        }
        
        if shouldThrowError {
            throw NSError(domain: "MockRepositoryError", code: 1, userInfo: nil)
        }
        
        return mockUser ?? .init()
    }
}

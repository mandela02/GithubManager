//
//  TestableUserDetailRepository.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//

@testable import GithubManager
import XCTest

// Testable subclass that allows injecting mocks
class TestableUserDetailRepository: UserDetailRepository {
    var mockResult: UserDetailModel?
    var mockError: Error?
    
    var lastLogin: String?
    
    init() {
        super.init(endpoint: "api.github.com")
    }

    override func getUser(login: String) async throws -> UserDetailModel {
        lastLogin = login
        
        if let error = mockError {
            throw error
        }
            
        return mockResult ?? .init()

    }
}

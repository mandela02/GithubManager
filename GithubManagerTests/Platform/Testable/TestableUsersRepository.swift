//
//  TestableUsersRepository.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//

@testable import GithubManager
import XCTest

// Testable subclass that allows injecting mocks
class TestableUsersRepository: UsersRepository {
    private let mockFileManager: MockFileManager
    
    var mockResult: [UserModel]?
    var mockError: Error?
    
    var perPage: Int?
    var since: Int?
    
    var cachedUsers: [UserModel]?

    init(mockFileManager: MockFileManager) {
        self.mockFileManager = mockFileManager
        super.init(endpoint: "api.github.com")
    }
    
    override func getUsers(perPage: Int, since: Int) async throws -> [UserModel] {
        self.perPage = perPage
        self.since = since
        
        if let error = mockError {
            throw error
        }
        
        return mockResult ?? []
    }
    
    override func readStringFromFile(fileName: String) throws -> String? {
        if !mockFileManager.fileExists(at: fileName) {
            try mockFileManager.writeString("[]", to: fileName)
        }
        return try mockFileManager.readString(from: fileName)
    }
    
    override func saveStringToFile(_ string: String, fileName: String) throws {
        try mockFileManager.writeString(string, to: fileName)
    }
}

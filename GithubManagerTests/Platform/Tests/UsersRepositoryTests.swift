//
//  UsersRepositoryTests.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//

@testable import GithubManager
import XCTest

class UsersRepositoryTests: XCTestCase {
    var repository: TestableUsersRepository!
    var mockFileManager: MockFileManager!
    
    // Test file name
    let testFileName = "test_favorites.txt"
    
    let sampleUsers = [
        UserModel(
            login: "a",
            avatarURL: "avatar.a",
            htmlURL: "github.com/users/a"
        ),
        UserModel(
            login: "b",
            avatarURL: "avatar.b",
            htmlURL: "github.com/users/n"
        )
    ]
    
    let sampleJSON = """
    [
        {
            "login": "a",
            "avatar_url": "avatar.a",
            "html_url": "github.com/users/a"
        },
        {
            "login": "b",
            "avatar_url": "avatar.b",
            "html_url": "github.com/users/b"
        }
    ]
    """
    
    override func setUp() {
        super.setUp()
        // Create a testable subclass that exposes our mocks
        mockFileManager = MockFileManager()
        repository = TestableUsersRepository(mockFileManager: mockFileManager)
    }
    
    override func tearDown() {
        repository = nil
        mockFileManager = nil
        super.tearDown()
    }
    
    func testGetUserSucccess() async throws {
        // Set up expected response
        repository.mockResult = sampleUsers
        
        // Call the method
        let result = try await repository.getUsers(perPage: 1, since: 20)
        
        // Verify
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].login, "a")
        XCTAssertEqual(result[1].avatarURL, "avatar.b")
        XCTAssertEqual(repository.perPage, 1)
        XCTAssertEqual(repository.since, 20)
    }

    func testGetUsersError() async {
        // Set up expected error
        let mockError = NSError(domain: "NetworkError", code: 404, userInfo: nil)
        repository.mockError = mockError
        
        // Call and verify
        do {
            _ = try await repository.getUsers(perPage: 1, since: 20)
            XCTFail("Expected error was not thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, "NetworkError")
            XCTAssertEqual((error as NSError).code, 404)
        }
    }

    func testGetUsersEmpty() async throws {
        // Set up nil response
        repository.mockResult = nil
        
        // Call the method
        let result = try await repository.getUsers(perPage: 1, since: 20)

        // Verify
        XCTAssertEqual(result.count, 0)
        XCTAssertTrue(result.isEmpty)
    }
    
    func testGetCachedUsers() throws {
        // Set up mock file content
        mockFileManager.mockFileExists = true
        mockFileManager.mockFileContent = sampleJSON
        
        // Call the method
        let result = try repository.getCachedUser(fileName: testFileName)
        
        // Verify
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].login, "a")
        XCTAssertEqual(result[1].avatarURL, "avatar.b")
        XCTAssertEqual(mockFileManager.lastReadFileName, testFileName)
    }
    
    func testGetCachedUsersNotExist() throws {
        // Set up mock - file doesn't exist initially but will be created
        mockFileManager.mockFileExists = false
        
        // Verify file creation with empty array
        let result = try repository.getCachedUser(fileName: testFileName)

        // Verify
        XCTAssertEqual(result.count, 0)
        XCTAssertTrue(result.isEmpty)
        XCTAssertEqual(mockFileManager.lastWrittenString, "[]")
        XCTAssertEqual(mockFileManager.lastWrittenFileName, testFileName)
    }
    
    func testGetCachedUsersInvalidJSON() throws {
        // Setup invalid JSON
        mockFileManager.mockFileExists = true
        mockFileManager.mockFileContent = "This is not valid JSON"
        
        // Should attempt to parse but return empty array on failure
        do {
            let result = try repository.getCachedUser(fileName: testFileName)
            XCTAssertEqual(result.count, 0)
        } catch {
            // Optionally: if your implementation throws on invalid JSON, test for that instead
            XCTAssertTrue(error is DecodingError)
        }
    }

    func testGetCachedUserError() {
        // Set up mock file error
        mockFileManager.mockFileExists = true
        mockFileManager.mockFileError = NSError(domain: "FileError", code: 1, userInfo: nil)
        
        // Call and verify
        do {
            _ = try repository.getCachedUser(fileName: testFileName)
            XCTFail("Expected error was not thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, "FileError")
        }
    }
    
    func testSaveCachedUsers() throws {
        // Call the method
        try repository.saveCachedUser(users: sampleUsers, fileName: testFileName)
        
        // Verify
        XCTAssertEqual(mockFileManager.lastWrittenFileName, testFileName)
        XCTAssertTrue(mockFileManager.lastWrittenString.contains("avatar.a"))
        XCTAssertTrue(mockFileManager.lastWrittenString.contains("avatar.b"))
    }
    
    func testSaveCachedUsersEmptyArray() throws {
        // Call with empty array
        try repository.saveCachedUser(users: [], fileName: testFileName)
        
        // Verify
        XCTAssertEqual(mockFileManager.lastWrittenString, "[]")
    }
    
    func testSaveCachesUsersFileError() {
        // Set up mock write error
        mockFileManager.mockFileError = NSError(domain: "FileWriteError", code: 2, userInfo: nil)
        
        // Call and verify
        do {
            try repository.saveCachedUser(users: sampleUsers, fileName: testFileName)
            XCTFail("Expected error was not thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, "FileWriteError")
        }
    }
}

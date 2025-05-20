//
//  GetCachedUsersUseCaseTest.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//

import XCTest
@testable import GithubManager

class GetCachedUsersUseCaseTest: XCTestCase {
    
    // Test subject
    var useCase: GetCachedUsersUseCase!
    
    // Mock dependencies
    var mockRepository: MockUsersRepository!
    
    // Test data
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

    override func setUp() {
        super.setUp()
        mockRepository = MockUsersRepository(endpoint: "api.github.com")
        useCase = GetCachedUsersUseCase(usersRepository: mockRepository)
    }
    
    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func testSuccess() async throws {
        // Setup: Repository will return sample models
        mockRepository.mockCachedUsers = sampleUsers
        
        // Execute use case
        let result = try await useCase.run()
        
        // Verify
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].login, "a")
        XCTAssertEqual(result[0].avatar, "avatar.a")
        XCTAssertEqual(result[1].login, "b")
        XCTAssertEqual(result[1].avatar, "avatar.b")
        
        // Verify correct filename was used
        XCTAssertEqual(mockRepository.lastRequestedFileName, Constants.users)
    }
    
    func testEmpty() async throws {
        // Setup: Repository will return empty array
        mockRepository.mockCachedUsers = []
        
        // Execute use case
        let result = try await useCase.run()
        
        // Verify
        XCTAssertEqual(result.count, 0)
        XCTAssertTrue(result.isEmpty)
        
        // Verify correct filename was used
        XCTAssertEqual(mockRepository.lastRequestedFileName, Constants.users)
    }
    
    func testError() async {
        // Setup: Make repository throw an error
        mockRepository.shouldThrowError = true
        do {
            _ = try await useCase.run()
            XCTFail("Expected error was not thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, "MockRepositoryError")
        }
    }
}

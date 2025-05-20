//
//  GetUserUseCase.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//

import XCTest
@testable import GithubManager

class GetUserUseCaseTest: XCTestCase {
    
    // Test subject
    var useCase: GetUserUseCase!
    
    // Mock dependencies
    var mockRepository: MockUserDetailRepository!
    
    // Test data
    let sampleUser = UserDetailModel(
        id: 1,
        login: "a",
        name: "Mr A",
        avatarUrl: "avatar.a",
        htmlUrl: "github.com/users/a"
    )

    override func setUp() {
        super.setUp()
        mockRepository = MockUserDetailRepository(endpoint: "api.github.com")
        useCase = GetUserUseCase(userDetailRepository: mockRepository)
    }
    
    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func testSuccess() async throws {
        // Setup: Repository will return sample models
        mockRepository.mockUser = sampleUser
        
        // Execute use case
        let result = try await useCase.run(input: .init(login: "a"))
        
        // Verify
        XCTAssertEqual(result.htmlUrl, "github.com/users/a")
        XCTAssertEqual(result.login, "a")
        XCTAssertEqual(result.avatar, "avatar.a")
        
        // Verify correct filename was used
        XCTAssertEqual(mockRepository.login, "a")
        XCTAssertEqual(mockRepository.getUserCalled, true)
        XCTAssertEqual(mockRepository.getUserCallCount, 1)
    }
    
    
    func testError() async {
        // Setup: Make repository throw an error
        mockRepository.shouldThrowError = true
        do {
            _ = try await useCase.run(input: .init(login: "a"))
            XCTFail("Expected error was not thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, "MockRepositoryError")
        }
    }
}

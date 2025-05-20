//
//  UserDetailRepositoryTest.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//

@testable import GithubManager
import XCTest

class UserDetailRepositoryTest: XCTestCase {
    var repository: TestableUserDetailRepository!
    
    let sampleUser = UserDetailModel(
        id: 1,
        login: "a",
        name: "Mr A",
        avatarUrl: "avatar.a",
        htmlUrl: "github.com/users/a"
    )
        
    override func setUp() {
        super.setUp()
        // Create a testable subclass that exposes our mocks
        repository = TestableUserDetailRepository()
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    func testGetUserSucccess() async throws {
        // Set up expected response
        repository.mockResult = sampleUser
        
        // Call the method
        let result = try await repository.getUser(login: "a")
        
        // Verify
        XCTAssertEqual(result.avatarUrl, "avatar.a")
        XCTAssertEqual(result.login, "a")
        XCTAssertEqual(result.name, "Mr A")
        XCTAssertEqual(repository.lastLogin, "a")
    }

    func testGetUsersError() async {
        // Set up expected error
        let mockError = NSError(domain: "NetworkError", code: 404, userInfo: nil)
        repository.mockError = mockError
        
        // Call and verify
        do {
            _ = try await repository.getUser(login: "a")
            XCTFail("Expected error was not thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, "NetworkError")
            XCTAssertEqual((error as NSError).code, 404)
        }
    }
}

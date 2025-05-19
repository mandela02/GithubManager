//
//  GetUserUseCase.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

public class GetUserUseCase {
    public init(
        userDetailRepository: UserDetailRepository
    ) {
        self.userDetailRepository = userDetailRepository
    }
    
    
    public let userDetailRepository: UserDetailRepository
    
    public struct Input {
        public init(login: String) {
            self.login = login
        }
        
        let login: String
    }
    
    public func run(input: Input) async throws -> UserDetail {
        let result = try await userDetailRepository.getUser(login: input.login)
        return result.toObject()
    }
}

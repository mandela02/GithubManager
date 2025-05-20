//
//  GetCachedUsersUseCase.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

public class GetCachedUsersUseCase {
    public init(
        usersRepository: UsersRepository
    ) {
        self.usersRepository = usersRepository
    }
    
    
    public let usersRepository: UsersRepository
    
    public struct Input {
        public init(
        ) {
        }
    }
    
    public func run() async throws -> [User] {
        let result = try usersRepository.getCachedUser(fileName: Constants.users)
        return result.map { $0.toObject() }
    }
}

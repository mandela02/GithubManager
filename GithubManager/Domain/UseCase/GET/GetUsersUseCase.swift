//
//  GetUsersUseCase.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

public class GetUsersUseCase {
    public init(
        usersRepository: UsersRepository
    ) {
        self.usersRepository = usersRepository
    }
    
    
    public let usersRepository: UsersRepository
    
    public struct Input {
        public init(
            page: Int,
            perPage: Int
        ) {
            self.page = page
            self.perPage = perPage
        }
        
        let page: Int
        let perPage: Int
    }
    
    public func run(input: Input) async throws -> [User] {
        let result = try await usersRepository.getUsers(
            perPage: input.perPage,
            since: (input.page) * input.perPage
        )
        return result.map { $0.toObject() }
    }
}

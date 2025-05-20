//
//  UseCaseProviderProtocol.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

public protocol UseCaseProviderProtocol {
    func getUserUseCase() -> GetUserUseCase
    func getUsersUseCase() -> GetUsersUseCase
    func getCachedUsersUseCase() -> GetCachedUsersUseCase
}

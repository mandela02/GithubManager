//
//  HomeViewModel.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import SwiftUtilities
import Foundation
import DataLayer

class HomeViewModel: ObservableObject {
    init(env: Environment) {
        self.state = State()
        
        self.getUsersUseCase = env.useCaseProvider.getUsersUseCase()
        self.getCachedUsersUseCase = env.useCaseProvider.getCachedUsersUseCase()
    }
    
    private let getUsersUseCase: GetUsersUseCase
    private let getCachedUsersUseCase: GetCachedUsersUseCase
    
    @Published
    var state: State
    
    func loadCachedUsers() async {
        do {
            Task { @MainActor in
                state.loadingStatus = .inProcess
            }
            let users = try await getCachedUsersUseCase.run()
            Task { @MainActor in
                state.users += users
                state.loadingStatus = .success
            }
        } catch {
            Task { @MainActor in
                state.loadingStatus = error.toLoadingStatus
            }
        }
    }
    
    func loadRemoteUser() async {
        guard let nextPage = state.page else {
            return
        }

        do {
            Task { @MainActor in
                state.loadingStatus = .inProcess
            }
            let users = try await getUsersUseCase.run(input: .init(page: nextPage, perPage: 20))
            Task { @MainActor in
                if users.count < 20 {
                    state.page = nil
                    Settings.isFinish.value = true
                } else {
                    state.page = nextPage + 1
                    Settings.nextPage.value = nextPage + 1
                }
                
                state.users += users

                state.loadingStatus = .success
            }
        } catch {
            Task { @MainActor in
                state.loadingStatus = error.toLoadingStatus
            }
        }
    }
    
    public func loadMoreIfNeeded(current: User) {
        if state.loadingStatus == .inProcess { return }
        Task {
            guard let index = state.users.firstIndex(of: current) else {
                return
            }

            if index == state.users.endIndex - 5 {
                await loadRemoteUser()
            }
        }
    }
}

extension HomeViewModel {
    struct State {
        var loadingStatus: LoadingStatus = .initial
        var users: [User] = []
        
        var page: Int? = Settings.nextPage.value
    }
}

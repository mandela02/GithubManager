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
    }
    
    private let getUsersUseCase: GetUsersUseCase
    
    @Published
    var state: State
    
    func initState() async {
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
                } else {
                    state.page = nextPage + 1
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
                await initState()
            }
        }
    }
}

extension HomeViewModel {
    struct State {
        var loadingStatus: LoadingStatus = .initial
        var users: [User] = []
        
        var page: Int? = 0
    }
}

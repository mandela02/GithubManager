//
//  UserViewModel.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import SwiftUtilities
import Foundation
import DataLayer

class UserViewModel: ObservableObject {
    init(
        env: Environment,
        login: String
    ) {
        self.state = State(login: login)
        
        self.getUserUseCase = env.useCaseProvider.getUserUseCase()
    }
    
    private let getUserUseCase: GetUserUseCase
    
    @Published
    var state: State
    
    func initState() async {
        do {
            Task { @MainActor in
                state.loadingStatus = .inProcess
            }
            let user = try await getUserUseCase.run(input: .init(login: state.login))
            Task { @MainActor in
                state.user = user
                state.loadingStatus = .success
            }
        } catch {
            Task { @MainActor in
                state.loadingStatus = error.toLoadingStatus
            }
        }
    }
}

extension UserViewModel {
    struct State {
        let login: String
        
        var loadingStatus: LoadingStatus = .initial
        var user: UserDetail?
    }
}

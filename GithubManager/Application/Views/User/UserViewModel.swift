//
//  UserViewModel.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import SwiftUtilities
import Foundation
import DataLayer

/// ViewModel responsible for managing and loading detailed user information.
class UserViewModel: ObservableObject {

    /// Initializes the `UserViewModel` with the provided environment and user login.
    ///
    /// - Parameters:
    ///   - env: The environment containing the use case provider.
    ///   - login: The login identifier for the user to be loaded.
    init(
        env: Environment,
        login: String
    ) {
        self.state = State(login: login)
        self.getUserUseCase = env.useCaseProvider.getUserUseCase()
    }

    private let getUserUseCase: GetUserUseCase

    /// Published state that holds user detail and loading status.
    @Published
    var state: State

    /// Loads user details using the login provided in the state.
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

    /// Holds the state for the `UserViewModel`, including login, user detail, and loading status.
    struct State {
        /// The login identifier for the user.
        let login: String

        /// Current loading status.
        var loadingStatus: LoadingStatus = .initial

        /// Loaded user detail, if available.
        var user: UserDetail?
    }
}

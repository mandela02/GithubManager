//
//  HomeViewModel.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import SwiftUtilities
import Foundation
import DataLayer

/// ViewModel responsible for managing user data on the Home screen.
/// It coordinates loading from both local cache and remote source.
class HomeViewModel: ObservableObject {

    /// Initializes the `HomeViewModel` with the provided environment dependencies.
    ///
    /// - Parameter env: The environment containing the use case provider.
    init(env: Environment) {
        self.state = State()
        self.getUsersUseCase = env.useCaseProvider.getUsersUseCase()
        self.getCachedUsersUseCase = env.useCaseProvider.getCachedUsersUseCase()
    }

    private let getUsersUseCase: GetUsersUseCase
    private let getCachedUsersUseCase: GetCachedUsersUseCase

    /// Published UI state to trigger updates in SwiftUI views.
    @Published
    var state: State

    /// Loads users from local cache and updates the view state.
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

    /// Loads users from the remote source and updates the view state.
    /// Updates pagination and settings flags accordingly.
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

    /// Triggers loading more users if the current user is near the end of the list.
    ///
    /// - Parameter current: The user currently being displayed or interacted with.
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

    /// Holds the state for the `HomeViewModel`, including user list, pagination, and loading status.
    struct State {
        /// Current loading status.
        var loadingStatus: LoadingStatus = .initial

        /// The list of users displayed.
        var users: [User] = []

        /// The next page to be loaded; `nil` if all pages are loaded.
        var page: Int? = Settings.nextPage.value
    }
}

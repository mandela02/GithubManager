//
//  ContentViewModel.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//


import NavigationTemplateByTriBQ
import SwiftUI

/// A property wrapper that provides access to the `ContentNavigator` instance stored in the environment.
///
/// This property wrapper is used to interact with the `ContentNavigator` instance within a SwiftUI view. It is a dynamic property and automatically updates the view when the underlying `ContentNavigator` changes.
///
/// Usage:
/// ```
/// @WrappedContentNavigator var navigator // Access the wrapped `ContentNavigator` instance.
/// ```

@propertyWrapper
struct WrappedContentNavigator: DynamicProperty {
    /// The private property that stores the `ContentNavigator` instance from the environment.
    @EnvironmentObject private var manager: ContentNavigator

    /// The wrapped value representing the `ContentNavigator` instance.
    var wrappedValue: ContentNavigator { self.manager }

    /// The projected value providing access to the `EnvironmentObject` wrapper for `ContentNavigator`.
    var projectedValue: EnvironmentObject<ContentNavigator>.Wrapper { self.$manager }

    /// Initializes a new `WrappedAppManager` property wrapper.
    ///
    /// This initializer does not require any parameters.
    init() {}
}

/// A navigator responsible for handling navigation logic in the app's main content flow.
/// Manages push and presentable destinations based on user interactions.
class ContentNavigator: Navigator<ContentNavigator.Pushed, ContentNavigator.Presented> {

    /// The environment instance used to configure dependencies throughout the navigation flow.
    let environment: Environment

    /// Initializes the `ContentNavigator` with a default GitHub API endpoint.
    override init() {
        self.environment = Environment(endpoint: "api.github.com")
    }

    /// Full screen presentables handled by this navigator.
    override var fullScreenPresentables: [Presented] {
        []
    }

    /// Modal presentables handled by this navigator.
    override var modalPresentables: [Presented] {
        []
    }

    /// Defines pushable destinations for navigation.
    enum Pushed: Pushable {

        /// Represents a user screen destination with associated user data.
        case user(user: User)

        /// Identifies the destination uniquely.
        var id: Pushed { self }

        /// Equatable conformance to ensure navigation state comparison is based on user ID.
        static func == (lhs: ContentNavigator.Pushed, rhs: ContentNavigator.Pushed) -> Bool {
            switch (lhs, rhs) {
            case let (.user(lhsUser), .user(rhsUser)):
                return lhsUser.id == rhsUser.id
            }
        }

        /// Hashable conformance to support collection use (e.g., in Sets or Dictionaries).
        func hash(into hasher: inout Hasher) {
            switch self {
            case .user(let user):
                hasher.combine("user")
                hasher.combine(user.id)
            }
        }
    }

    /// Defines presentable (modal or fullscreen) destinations.
    enum Presented: Presentable {

        /// Returns a unique identifier for the presented view.
        var id: String { UUID().uuidString }
    }
}

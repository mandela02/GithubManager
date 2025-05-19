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

class ContentNavigator: Navigator<ContentNavigator.Pushed, ContentNavigator.Presented> {
    override init() {
        self.environment = Environment(endpoint: "api.github.com")
    }
    
    let environment: Environment

    override var fullScreenPresentables: [Presented] {
        []
    }

    override var modalPresentables: [Presented] {
        []
    }
    
    enum Pushed: Pushable {
        static func == (lhs: ContentNavigator.Pushed, rhs: ContentNavigator.Pushed) -> Bool {
            switch (lhs, rhs) {
            case let (.user(lhsUser), .user(rhsUser)):
                return lhsUser.id == rhsUser.id
            }
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .user(let user):
                hasher.combine("user")
                hasher.combine(user.id)
            }
        }
        
        var id: Pushed { self }
        
        case user(user: User)
    }

    enum Presented: Presentable {
        var id: String { UUID().uuidString }
    }
}


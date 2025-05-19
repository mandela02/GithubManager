//
//  ContentView.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//


import SwiftUI
import NavigationTemplateByTriBQ

struct ContentView: View {
    @StateObject
    var navigator: ContentNavigator = ContentNavigator()

    var body: some View {
        NavigationControllerView(navigator: navigator) {
            HomeView(viewModel: .init(env: navigator.environment))
        } pushDestination: { route in
            switch route {
            case .user(user: let user):
                UserView(viewModel: .init(env: navigator.environment, login: user.login))
            }
        } presentDestination: { portal in
        }
        .environmentObject(navigator)
        .preferredColorScheme(.light)
    }
}

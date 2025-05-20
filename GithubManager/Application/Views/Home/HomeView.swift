//
//  HomeView.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import SwiftUI

struct HomeView: View {
    init(viewModel: HomeViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    @StateObject
    var viewModel: HomeViewModel
    
    @WrappedContentNavigator
    var navigator
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.state.users.lazy) { user in
                        UserTile(user: user)
                            .contentShape(Rectangle())
                            .padding(.horizontal, 20)
                            .onAppear {
                                viewModel.loadMoreIfNeeded(current: user)
                            }
                            .onTapGesture {
                                navigator.push(to: .user(user: user))
                            }
                    }
                }
            }
        }
        .navigationTitle("Github")
        .navigationBarTitleDisplayMode(.large)
        .viewDidLoad {
            if Settings.nextPage.value == 0 {
                await viewModel.loadRemoteUser()
            } else {
                await viewModel.loadCachedUsers()
            }
        }
    }
}

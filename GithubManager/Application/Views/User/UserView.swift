//
//  UserView.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import SwiftUI
import ViewExtensionForSwiftUI

struct UserView: View {
    init(viewModel: UserViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    @StateObject
    var viewModel: UserViewModel
    
    @WrappedContentNavigator
    var navigator
    
    var body: some View {
        ZStack(
            alignment: .topLeading
        ) {
            Color.white.ignoresSafeArea()
            
            VStack(
                alignment: .leading,
                spacing: 12
            ) {
                userView
                followView
                    .padding(.horizontal, 50)
                
                VStack(
                    alignment: .leading,
                    spacing: 20
                ) {
                    githubView
                    blogView
                }
            }
            .padding(.all, 20)
        }
        .task {
            await viewModel.initState()
        }
        .environment(\.openURL, OpenURLAction(handler: { url in
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: { success in
                    if success {
                        debugPrint("Opened URL \(url) successfully")
                    } else {
                        debugPrint("Failed to open URL \(url)")
                    }
                })
            } else {
                debugPrint("Can't open the URL: \(url)")
            }
            return .handled
        }))
    }
    
    @ViewBuilder
    private var userView: some View {
        if let user = viewModel.state.user {
            HStack(alignment: .top, spacing: 10) {
                NetworkImage(
                    url: user.avatar,
                    defaultImage: Image.personCircleFill
                )
                .frame(width: 100, height: 100)
                .cornerRadius(4, corners: .allCorners)
                
                VStack(alignment: .leading, spacing: 10) {
                    VStack(
                        alignment: .leading,
                        spacing: 4
                    ) {
                        Text(user.name)
                            .foregroundStyle(.black)
                            .font(.system(size: 20))
                        
                        Text(user.login)
                            .foregroundStyle(.gray)
                            .font(.system(size: 14))
                    }
                    
                    Divider()
                    
                    if !user.location.isEmpty {
                        HStack(spacing: 8) {
                            Image.mappinAndEllipse
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                            
                            Text(user.location)
                                .foregroundStyle(.gray)
                                .font(.system(size: 12))
                        }
                    }
                    
                }
            }
            .padding(.all, 8)
            .backgroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: Color.black.opacity(0.3), radius: 10)
        }
    }
    
    @ViewBuilder
    private var followView: some View {
        if let user = viewModel.state.user {
            HStack {
                VStack(spacing: 6) {
                    Image.person2Fill
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(.all, 10)
                        .backgroundColor("D3D3D3".color)
                        .clipShape(Circle())
                    
                    Text("\(user.followers)")
                        .foregroundStyle(.black)
                        .font(.system(size: 14))
                    
                    Text("Followers")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12))
                }
                .frame(maxWidth: .infinity)
                
                VStack(spacing: 6) {
                    Image.medalFill
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(.all, 10)
                        .backgroundColor("D3D3D3".color)
                        .clipShape(Circle())
                    
                    Text("\(user.following)")
                        .foregroundStyle(.black)
                        .font(.system(size: 14))
                    
                    Text("Following")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12))
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    @ViewBuilder
    private var blogView: some View {
        if let user = viewModel.state.user, !user.blog.isEmpty {
            VStack(
                alignment: .leading,
                spacing: 8
            ) {
                Text("Blog")
                    .foregroundStyle(.black)
                    .font(.system(size: 24))
                
                Text(buildBlogAttributedString(of: user))
                    .foregroundStyle(.black)
                    .font(.system(size: 18))
            }
        }
    }
    
    private func buildBlogAttributedString(of user: UserDetail) -> AttributedString {
        var url = AttributedString(user.blog)
        url.link = URL(string: user.blog)
        url.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        url.foregroundColor = .blue
        url.underlineStyle = .single
        url.underlineColor = .blue
        return url
    }
    
    @ViewBuilder
    private var githubView: some View {
        if let user = viewModel.state.user, !user.htmlUrl.isEmpty {
            VStack(
                alignment: .leading,
                spacing: 8
            ) {
                Text("Github")
                    .foregroundStyle(.black)
                    .font(.system(size: 24))
                
                Text(buildHtmlAttributedString(of: user))
                    .foregroundStyle(.black)
                    .font(.system(size: 18))
            }
        }
    }
    
    private func buildHtmlAttributedString(of user: UserDetail) -> AttributedString {
        var url = AttributedString(user.htmlUrl)
        url.link = URL(string: user.htmlUrl)
        url.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        url.foregroundColor = .blue
        url.underlineStyle = .single
        url.underlineColor = .blue
        return url
    }
}

//
//  UserTile.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import SwiftUI
import ViewExtensionForSwiftUI

struct UserTile: View {
    public init(user: User) {
        self.user = user
    }
    
    private let user: User
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            NetworkImage(
                url: user.avatar,
                defaultImage: Image.personCircleFill
            )
            .frame(width: 100, height: 100)
            .cornerRadius(4, corners: .allCorners)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(user.login)
                    .foregroundStyle(.black)
                    .font(.system(size: 25))
                
                Divider()
                
                if !user.url.isEmpty {
                    Text(attributedString)
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
            }
        }
        .padding(.all, 8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 1)
        )
    }
    
    var attributedString: AttributedString {
        var url = AttributedString(user.url)
        url.link = URL(string: user.url)
        url.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        url.foregroundColor = .blue
        url.underlineStyle = .single
        url.underlineColor = .blue
        return url
    }
}

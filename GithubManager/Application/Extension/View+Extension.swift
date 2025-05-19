//
//  View+Extension.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import SwiftUI
import SwiftUtilities

extension View {
    @ViewBuilder
    func viewDidLoad(initState: @escaping AsyncVoidCallback) -> some View {
        self
            .modifier(ViewDidLoadModifier(initState: initState))
    }
}

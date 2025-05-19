//
//  ViewDidLoadModifier.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import Foundation
import SwiftUI
import SwiftUtilities

struct ViewDidLoadModifier: ViewModifier {
    @State
    private var isFirstTime = true

    let initState: AsyncVoidCallback

    func body(content: Content) -> some View {
        content
            .onAppear {
                Task { @MainActor in
                    if isFirstTime {
                        isFirstTime = false
                        await initState()
                    }
                }
            }
    }
}

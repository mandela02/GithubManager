//
//  Settings.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//

import SwiftUtilities

public enum SettingKey: String {
    case nextPage
    case isFinish
}

public enum Settings {
    public static var nextPage = UserDefault<Int>(
        key: SettingKey.nextPage.rawValue,
        defaultValue: 0
    )
    
    public static var isFinish = UserDefault<Bool>(
        key: SettingKey.isFinish.rawValue,
        defaultValue: false
    )
}

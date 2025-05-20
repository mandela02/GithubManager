//
//  Settings.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//

import SwiftUtilities

/// A collection of keys used for storing and retrieving app settings from UserDefaults.
public enum SettingKey: String {
    case nextPage
    case isFinish
}

/// A namespace containing static properties that represent user-configurable settings,
/// backed by `UserDefault` wrappers to persist values using UserDefaults.
public enum Settings {
    
    /// Stores the index of the next page to be fetched.
    /// Default value is `0`.
    public static var nextPage = UserDefault<Int>(
        key: SettingKey.nextPage.rawValue,
        defaultValue: 0
    )
    
    /// Indicates whether the final page of data has been reached.
    /// Default value is `false`.
    public static var isFinish = UserDefault<Bool>(
        key: SettingKey.isFinish.rawValue,
        defaultValue: false
    )
}

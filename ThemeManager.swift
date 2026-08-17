//
//  ThemeManager.swift
//  ChangeMakers PT
//
//  Created by RamSST on 17/8/26.
//

import SwiftUI
import Combine

class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme {
        didSet {
            UserDefaults.standard.set(currentTheme.rawValue, forKey: "selectedTheme")
        }
    }

    init() {
        let saved = UserDefaults.standard.string(forKey: "selectedTheme") ?? AppTheme.classic.rawValue
        self.currentTheme = AppTheme(rawValue: saved) ?? .classic
    }
}

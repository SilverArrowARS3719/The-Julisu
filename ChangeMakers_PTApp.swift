//
//  ChangeMakers_PTApp.swift
//  ChangeMakers PT
//
//  Created by RamSST on 16/8/26.
//

import SwiftUI

@main
struct ChangeMakers_PTApp: App {
    @StateObject var themeManager = ThemeManager()
    @StateObject var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .environmentObject(authManager)
        }
    }
}

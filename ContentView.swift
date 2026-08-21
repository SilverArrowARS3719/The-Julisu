//
//  ContentView.swift
//  ChangeMakers PT
//
//  Created by RamSST on 16/8/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        if authManager.isLoggedIn {
            TaskListView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
        .environmentObject(AuthManager())
}


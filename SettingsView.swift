//
//  SettingsView.swift
//  ChangeMakers PT
//
//  Created by RamSST on 17/8/26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss

    let columns = [GridItem(.adaptive(minimum: 100))]

    var body: some View {
        NavigationView {
            ZStack {
                themeManager.currentTheme.backgroundColor.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Choose a Theme")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top)

                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(AppTheme.allCases) { theme in
                                themeSwatch(theme)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }

    @ViewBuilder
    func themeSwatch(_ theme: AppTheme) -> some View {
        Button(action: {
            themeManager.currentTheme = theme
        }) {
            VStack(spacing: 8) {
                Circle()
                    .fill(theme.swatchColor)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Circle()
                            .stroke(Color.primary, lineWidth: themeManager.currentTheme == theme ? 3 : 0)
                            .padding(-4)
                    )

                Text(theme.rawValue)
                    .font(.caption)
                    .foregroundColor(themeManager.currentTheme.textColor)
            }
        }
    }
}

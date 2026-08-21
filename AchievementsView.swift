//
//  AchievementsView.swift
//  ChangeMakers PT
//
//  Created by RamSST on 18/8/26.
//

import SwiftUI

struct AchievementsView: View {
    @ObservedObject var viewModel: TaskListViewModel
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ZStack {
                themeManager.currentTheme.backgroundColor.ignoresSafeArea()

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(1...10, id: \.self) { level in
                            achievementCard(level: level)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Achievements")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }

    @ViewBuilder
    func achievementCard(level: Int) -> some View {
        let unlocked = viewModel.unlockedLevels.contains(level)

        VStack(spacing: 8) {
            if unlocked {
                TreeView(level: level, progress: 1.0)
                    .frame(height: 100)
                    .scaleEffect(0.6)
            } else {
                Image(systemName: "lock.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.gray.opacity(0.4))
                    .frame(height: 100)
            }

            Text("Level \(level)")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(unlocked ? themeManager.currentTheme.textColor : .gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(themeManager.currentTheme.cardColor)
        .cornerRadius(16)
        .opacity(unlocked ? 1.0 : 0.5)
    }
}

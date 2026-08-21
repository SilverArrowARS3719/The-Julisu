//
//  ReflectionView.swift
//  ChangeMakers PT
//
//  Created by RamSST on 19/8/26.
//

import SwiftUI

struct ReflectionView: View {
    @ObservedObject var viewModel: TaskListViewModel
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss

    let task: UserTask

    @State private var whatDone = ""
    @State private var howFelt = ""
    @State private var whatLearned = ""

    var body: some View {
        NavigationView {
            ZStack {
                themeManager.currentTheme.backgroundColor.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Great job finishing:")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(task.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(themeManager.currentTheme.textColor)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("What did you actually get done?")
                                .font(.headline)
                            TextEditor(text: $whatDone)
                                .frame(height: 80)
                                .padding(4)
                                .background(themeManager.currentTheme.cardColor)
                                .cornerRadius(10)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("How did you feel while doing it?")
                                .font(.headline)
                            TextEditor(text: $howFelt)
                                .frame(height: 80)
                                .padding(4)
                                .background(themeManager.currentTheme.cardColor)
                                .cornerRadius(10)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("What would you do differently next time?")
                                .font(.headline)
                            TextEditor(text: $whatLearned)
                                .frame(height: 80)
                                .padding(4)
                                .background(themeManager.currentTheme.cardColor)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            viewModel.finishCompletingTask(task, whatDone: whatDone, howFelt: howFelt, whatLearned: whatLearned)
                            dismiss()
                        }) {
                            Text("Save Reflection")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(themeManager.currentTheme.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.top, 8)
                    }
                    .padding()
                }
            }
            .navigationTitle("Reflection")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Skip") {
                        viewModel.finishCompletingTask(task, whatDone: "", howFelt: "", whatLearned: "")
                        dismiss()
                    }
                }
            }
        }
    }
}

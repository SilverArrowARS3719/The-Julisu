//
//  TaskListView.swift
//  ChangeMakers PT
//
//  Created by RamSST on 16/8/26.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel = TaskListViewModel()
    @State private var showingAddTask = false

    var body: some View {
        NavigationView {
            VStack {
                // Tree progress section
                VStack {
                    Image(viewModel.treeImageName())
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)

                    Text("Tree Level \(viewModel.treeLevel)")
                        .font(.headline)

                    Text("\(viewModel.completedCount)/\(viewModel.tasksNeededForNextLevel) tasks to next level")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()

                // Task list
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.name)
                                    .strikethrough(task.isCompleted)
                                Text(task.category == "Studies" ? "\(task.category) - \(task.subject)" : task.category)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                if !task.notes.isEmpty {
                                    Text(task.notes)
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()
                            if !task.isCompleted {
                                Button("Done") {
                                    viewModel.completeTask(task)
                                }
                            } else {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddTask = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
    }
}

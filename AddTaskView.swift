//
//  AddTaskView.swift
//  ChangeMakers PT
//
//  Created by RamSST on 16/8/26.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var viewModel: TaskListViewModel
    @Environment(\.dismiss) var dismiss

    @State private var taskName = ""
    @State private var category = "Studies"
    @State private var subject = "Math"
    @State private var notes = ""

    let categories = ["Studies", "Personal"]
    let subjects = ["Math", "Science", "English", "History"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Name")) {
                    TextField("Enter task name", text: $taskName)
                }

                Section(header: Text("Category")) {
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { cat in
                            Text(cat)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                if category == "Studies" {
                    Section(header: Text("Subject")) {
                        Picker("Subject", selection: $subject) {
                            ForEach(subjects, id: \.self) { subj in
                                Text(subj)
                            }
                        }
                    }
                }

                Section(header: Text("Notes")) {
                    TextField("Add notes (e.g. deadline)", text: $notes)
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.addTask(
                            name: taskName,
                            category: category,
                            subject: category == "Studies" ? subject : "",
                            notes: notes
                        )
                        dismiss()
                    }
                    .disabled(taskName.isEmpty)
                }
            }
        }
    }
}

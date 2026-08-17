//
//  TaskListViewModel.swift
//  ChangeMakers PT
//
//  Created by RamSST on 16/8/26.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var completedCount: Int = 0
    @Published var treeLevel: Int = 1
    @Published var tasksNeededForNextLevel: Int = 5

    func addTask(name: String, category: String, subject: String, notes: String) {
        let newTask = Task(name: name, category: category, subject: subject, notes: notes)
        tasks.append(newTask)
    }

    func completeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            if !tasks[index].isCompleted {
                tasks[index].isCompleted = true
                completedCount += 1
                checkTreeGrowth()
            }
        }
    }

    func checkTreeGrowth() {
        if completedCount >= tasksNeededForNextLevel {
            treeLevel += 1
            completedCount = 0
            tasksNeededForNextLevel += 5   // each level needs 5 more tasks than before
        }
    }

    func treeImageName() -> String {
        switch treeLevel {
        case 1:
            return "tree_sapling"
        case 2:
            return "tree_young"
        case 3:
            return "tree_mature"
        case 4:
            return "tree_flowering"
        default:
            return "tree_ancient"
        }
    }
}

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var tasks: [UserTask] = []
    @Published var completedCount: Int = 0
    @Published var treeLevel: Int = 1
    @Published var tasksNeededForNextLevel: Int = 5
    @Published var pulseTrigger: Bool = false
    @Published var unlockedLevels: Set<Int> = []

    let tasksPerLevel: [Int: Int] = [
        1: 5, 2: 6, 3: 7, 4: 8, 5: 9,
        6: 10, 7: 12, 8: 15, 9: 10, 10: 20
    ]

    var treeProgress: CGFloat {
        CGFloat(completedCount) / CGFloat(tasksNeededForNextLevel)
    }

    func addTask(name: String, category: String, subject: String, notes: String, deadline: Date?) {
        let newTask = UserTask(name: name, category: category, subject: subject, notes: notes, deadline: deadline)
        tasks.append(newTask)
        NotificationManager.shared.scheduleReminder(for: newTask)
    }

    func finishCompletingTask(_ task: UserTask, whatDone: String, howFelt: String, whatLearned: String) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = true
            tasks[index].reflectionWhatDone = whatDone
            tasks[index].reflectionHowFelt = howFelt
            tasks[index].reflectionWhatLearned = whatLearned

            NotificationManager.shared.cancelReminder(for: task)

            completedCount += 1
            pulseTrigger.toggle()
            checkTreeGrowth()
        }
    }

    func checkTreeGrowth() {
        if completedCount >= tasksNeededForNextLevel {
            let finishedLevel = treeLevel
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.unlockedLevels.insert(finishedLevel)
                self.treeLevel += 1
                self.completedCount = 0
                self.tasksNeededForNextLevel = self.tasksPerLevel[self.treeLevel] ?? (self.tasksNeededForNextLevel + 5)
            }
        }
    }

    // Clears only completed tasks - does not touch uncompleted ones or tree progress
    func clearCompletedTasks() {
        tasks.removeAll { $0.isCompleted }
    }
}

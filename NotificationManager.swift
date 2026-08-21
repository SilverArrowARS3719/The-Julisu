//
//  NotificationManager.swift
//  ChangeMakers PT
//
//  Created by RamSST on 19/8/26.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            }
        }
    }

    func scheduleReminder(for task: UserTask) {
        guard let deadline = task.deadline else { return }

        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = "Don't forget: \(task.name)"
        content.sound = .default

        // Remind 1 hour before deadline, only if deadline is in the future
        let reminderDate = deadline.addingTimeInterval(-3600)
        guard reminderDate > Date() else { return }

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    func cancelReminder(for task: UserTask) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task.id.uuidString])
    }
}

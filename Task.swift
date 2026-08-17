//
//  Task.swift
//  ChangeMakers PT
//
//  Created by RamSST on 16/8/26.
//

import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
    var name: String
    var category: String   // "Studies" or "Personal"
    var subject: String    // only used if category is "Studies"
    var notes: String
    var isCompleted: Bool = false
}

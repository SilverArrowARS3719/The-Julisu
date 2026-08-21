import Foundation

struct UserTask: Identifiable, Codable {
    var id = UUID()
    var name: String
    var category: String
    var subject: String
    var notes: String
    var isCompleted: Bool = false
    var reflectionWhatDone: String = ""
    var reflectionHowFelt: String = ""
    var reflectionWhatLearned: String = ""
    var deadline: Date? = nil
}

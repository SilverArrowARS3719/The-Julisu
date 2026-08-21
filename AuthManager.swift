import Foundation
import Combine
import SwiftUI

class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var userName: String = ""
    @Published var userHouse: String = ""
    @Published var profileImage: UIImage? = nil

    init() {
        if let savedName = UserDefaults.standard.string(forKey: "userName"),
           let savedHouse = UserDefaults.standard.string(forKey: "userHouse"),
           !savedName.isEmpty {
            self.userName = savedName
            self.userHouse = savedHouse
            self.isLoggedIn = true
        }
        loadProfileImage()
    }

    func login(name: String, password: String, house: String) {
        userName = name
        userHouse = house
        isLoggedIn = true

        UserDefaults.standard.set(name, forKey: "userName")
        UserDefaults.standard.set(house, forKey: "userHouse")
    }

    func logout() {
        isLoggedIn = false
        userName = ""
        userHouse = ""
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "userHouse")
    }

    // MARK: - Profile Picture

    private var profileImagePath: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("profileImage.jpg")
    }

    func saveProfileImage(_ image: UIImage) {
        profileImage = image
        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: profileImagePath)
        }
    }

    func loadProfileImage() {
        if let data = try? Data(contentsOf: profileImagePath),
           let image = UIImage(data: data) {
            profileImage = image
        }
    }

    func removeProfileImage() {
        profileImage = nil
        try? FileManager.default.removeItem(at: profileImagePath)
    }
}

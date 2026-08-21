//
//  ProfileImageView.swift
//  ChangeMakers PT
//
//  Created by RamSST on 20/8/26.
//

import SwiftUI

struct ProfileImageView: View {
    @EnvironmentObject var authManager: AuthManager
    var size: CGFloat = 40

    var body: some View {
        Group {
            if let image = authManager.profileImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray.opacity(0.5))
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}

//
//  ProfileView.swift
//  ChangeMakers PT
//
//  Created by RamSST on 20/8/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss

    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var showingRemoveConfirm = false

    var body: some View {
        NavigationView {
            ZStack {
                themeManager.currentTheme.backgroundColor.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        ProfileImageView(size: 140)
                            .overlay(
                                Circle()
                                    .stroke(themeManager.currentTheme.accentColor, lineWidth: 3)
                            )
                            .padding(.top, 30)

                        VStack(spacing: 6) {
                            Text(authManager.userName)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(themeManager.currentTheme.textColor)

                            Text(authManager.userHouse)
                                .font(.subheadline)
                                .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                        }

                        VStack(spacing: 12) {
                            PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                                HStack {
                                    Image(systemName: "photo.on.rectangle")
                                    Text("Choose from Photos")
                                }
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(themeManager.currentTheme.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            }

                            if authManager.profileImage != nil {
                                Button(action: { showingRemoveConfirm = true }) {
                                    Text("Remove Photo")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(themeManager.currentTheme.cardColor)
                                        .foregroundColor(.red)
                                        .cornerRadius(12)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
            .onChange(of: selectedPhotoItem) { _, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        authManager.saveProfileImage(uiImage)
                    }
                }
            }
            .alert("Remove profile photo?", isPresented: $showingRemoveConfirm) {
                Button("Cancel", role: .cancel) { }
                Button("Remove", role: .destructive) {
                    authManager.removeProfileImage()
                }
            }
        }
    }
}

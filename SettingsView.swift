import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.dismiss) var dismiss

    @State private var notificationsEnabled = true
    @State private var showingLogoutConfirm = false
    @State private var showingProfile = false

    let columns = [GridItem(.adaptive(minimum: 100))]

    let appShareURL = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID")!
    let shareMessage = "Check out TheJulisu - a study app that helps you stay focused and grow a tree as you complete tasks! 🌳"

    var body: some View {
        NavigationView {
            ZStack {
                themeManager.currentTheme.backgroundColor.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Profile")
                                .font(.headline)
                                .foregroundColor(themeManager.currentTheme.textColor)

                            Button(action: { showingProfile = true }) {
                                HStack {
                                    ProfileImageView(size: 44)
                                    VStack(alignment: .leading) {
                                        Text(authManager.userName)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(themeManager.currentTheme.textColor)
                                        Text(authManager.userHouse)
                                            .font(.caption)
                                            .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                                }
                                .padding()
                                .background(themeManager.currentTheme.cardColor)
                                .cornerRadius(14)
                            }
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Theme Color")
                                .font(.headline)
                                .foregroundColor(themeManager.currentTheme.textColor)

                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(AppTheme.allCases) { theme in
                                    themeSwatch(theme)
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Notifications")
                                .font(.headline)
                                .foregroundColor(themeManager.currentTheme.textColor)

                            Toggle("Task deadline reminders", isOn: $notificationsEnabled)
                                .tint(themeManager.currentTheme.accentColor)
                                .padding()
                                .background(themeManager.currentTheme.cardColor)
                                .cornerRadius(14)
                                .foregroundColor(themeManager.currentTheme.textColor)
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Invite Friends")
                                .font(.headline)
                                .foregroundColor(themeManager.currentTheme.textColor)

                            ShareLink(item: appShareURL, message: Text(shareMessage)) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                        .foregroundColor(themeManager.currentTheme.accentColor)
                                    Text("Share TheJulisu with friends")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(themeManager.currentTheme.textColor)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                                }
                                .padding()
                                .background(themeManager.currentTheme.cardColor)
                                .cornerRadius(14)
                            }
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("About")
                                .font(.headline)
                                .foregroundColor(themeManager.currentTheme.textColor)

                            VStack(spacing: 0) {
                                aboutRow(label: "App", value: "TheJulisu")
                                Divider()
                                aboutRow(label: "Version", value: "1.0")
                            }
                            .background(themeManager.currentTheme.cardColor)
                            .cornerRadius(14)
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Account")
                                .font(.headline)
                                .foregroundColor(themeManager.currentTheme.textColor)

                            Button(action: { showingLogoutConfirm = true }) {
                                Text("Log Out")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(themeManager.currentTheme.cardColor)
                                    .cornerRadius(14)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileView()
                    .environmentObject(themeManager)
                    .environmentObject(authManager)
            }
            .alert("Log Out?", isPresented: $showingLogoutConfirm) {
                Button("Cancel", role: .cancel) { }
                Button("Log Out", role: .destructive) {
                    authManager.logout()
                    dismiss()
                }
            } message: {
                Text("You'll need to sign in again next time.")
            }
        }
        .preferredColorScheme(themeManager.currentTheme.colorScheme)
    }

    @ViewBuilder
    func themeSwatch(_ theme: AppTheme) -> some View {
        Button(action: {
            themeManager.currentTheme = theme
        }) {
            VStack(spacing: 8) {
                Circle()
                    .fill(theme.swatchColor)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Circle()
                            .stroke(themeManager.currentTheme.textColor, lineWidth: themeManager.currentTheme == theme ? 3 : 0)
                            .padding(-4)
                    )

                Text(theme.rawValue)
                    .font(.caption)
                    .foregroundColor(themeManager.currentTheme.textColor)
            }
        }
    }

    @ViewBuilder
    func aboutRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundColor(themeManager.currentTheme.textColor)
            Spacer()
            Text(value)
                .foregroundColor(themeManager.currentTheme.secondaryTextColor)
        }
        .padding()
    }
}

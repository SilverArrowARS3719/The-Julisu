//
//  LoginView.swift
//  ChangeMakers PT
//
//  Created by RamSST on 20/8/26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var themeManager: ThemeManager

    @State private var name = ""
    @State private var password = ""
    @State private var selectedHouse = "Yellow House"
    @State private var showingError = false

    var body: some View {
        ZStack {
            themeManager.currentTheme.backgroundColor
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Image(systemName: "leaf.fill")
                            .font(.system(size: 50))
                            .foregroundColor(themeManager.currentTheme.accentColor)

                        Text("Welcome")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(themeManager.currentTheme.textColor)

                        Text("Let's get you set up")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 60)

                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Your Name")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(themeManager.currentTheme.textColor)
                            TextField("Enter your name", text: $name)
                                .padding()
                                .background(themeManager.currentTheme.cardColor)
                                .cornerRadius(12)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Password")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(themeManager.currentTheme.textColor)
                            SecureField("Enter a password", text: $password)
                                .padding()
                                .background(themeManager.currentTheme.cardColor)
                                .cornerRadius(12)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("What House Are You?")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(themeManager.currentTheme.textColor)

                            Picker("House", selection: $selectedHouse) {
                                ForEach(UserHouse.options, id: \.self) { house in
                                    Text(house).tag(house)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(themeManager.currentTheme.cardColor)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)

                    if showingError {
                        Text("Please fill in your name and password")
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    Button(action: attemptLogin) {
                        Text("Get Started")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(themeManager.currentTheme.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .padding(.bottom, 40)
            }
        }
    }

    func attemptLogin() {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.isEmpty else {
            showingError = true
            return
        }
        showingError = false
        authManager.login(name: name, password: password, house: selectedHouse)
    }
}

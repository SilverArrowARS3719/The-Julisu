//
//  AppTheme.swift
//  ChangeMakers PT
//
//  Created by RamSST on 17/8/26.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case classic = "Classic"
    case ocean = "Ocean"
    case sunset = "Sunset"
    case forest = "Forest"
    case lavender = "Lavender"
    case dark = "Dark"

    var id: String { rawValue }

    var backgroundColor: Color {
        switch self {
        case .classic: return Color(.systemGroupedBackground)
        case .ocean: return Color(red: 0.88, green: 0.95, blue: 0.98)
        case .sunset: return Color(red: 1.0, green: 0.93, blue: 0.86)
        case .forest: return Color(red: 0.9, green: 0.96, blue: 0.89)
        case .lavender: return Color(red: 0.94, green: 0.91, blue: 0.98)
        case .dark: return Color(red: 0.1, green: 0.1, blue: 0.12)
        }
    }

    var cardColor: Color {
        switch self {
        case .dark: return Color(red: 0.18, green: 0.18, blue: 0.2)
        default: return Color(.systemBackground)
        }
    }

    var accentColor: Color {
        switch self {
        case .classic: return .green
        case .ocean: return .blue
        case .sunset: return .orange
        case .forest: return Color(red: 0.2, green: 0.5, blue: 0.25)
        case .lavender: return .purple
        case .dark: return .mint
        }
    }

    var textColor: Color {
        self == .dark ? .white : .primary
    }

    var swatchColor: Color {
        accentColor
    }
}

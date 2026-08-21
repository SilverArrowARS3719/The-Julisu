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
        case .ocean: return Color(red: 0.85, green: 0.93, blue: 0.98)
        case .sunset: return Color(red: 1.0, green: 0.92, blue: 0.85)
        case .forest: return Color(red: 0.88, green: 0.95, blue: 0.88)
        case .lavender: return Color(red: 0.93, green: 0.89, blue: 0.98)
        case .dark: return Color(red: 0.08, green: 0.08, blue: 0.1)
        }
    }

    var cardColor: Color {
        switch self {
        case .dark: return Color(red: 0.16, green: 0.16, blue: 0.19)
        default: return Color(.systemBackground)
        }
    }

    // Accent used for buttons, progress bars, icons
    var accentColor: Color {
        switch self {
        case .classic: return .green
        case .ocean: return .blue
        case .sunset: return .orange
        case .forest: return Color(red: 0.13, green: 0.45, blue: 0.2)
        case .lavender: return .purple
        case .dark: return .mint
        }
    }

    // Primary text - readable on backgroundColor and cardColor
    var textColor: Color {
        self == .dark ? .white : .black
    }

    // Secondary text (captions, subtitles)
    var secondaryTextColor: Color {
        self == .dark ? Color.white.opacity(0.6) : Color.black.opacity(0.55)
    }

    // Swatch shown in Settings - now visually distinct from accentColor
    // so the "Dark" swatch actually looks dark, not teal/mint
    var swatchColor: Color {
        switch self {
        case .dark: return Color(red: 0.15, green: 0.15, blue: 0.17)
        default: return accentColor
        }
    }

    // Tells iOS whether to render system chrome (nav bar title, etc.) in light or dark style
    var colorScheme: ColorScheme {
        self == .dark ? .dark : .light
    }
}

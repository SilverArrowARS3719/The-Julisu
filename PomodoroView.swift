import SwiftUI

struct PomodoroView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var isPresented: Bool

    @State private var secondsRemaining = 25 * 60
    @State private var isRunning = false
    @State private var isBreak = false
    @State private var timer: Timer?

    let focusDuration = 25 * 60
    let breakDuration = 5 * 60

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(isBreak ? "Break Time" : "Focus Time")
                    .font(.headline)
                    .foregroundColor(themeManager.currentTheme.textColor)
                Spacer()
                Button(action: { withAnimation { isPresented = false } }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }

            Text(formattedTime)
                .font(.system(size: 40, weight: .bold, design: .monospaced))
                .foregroundColor(isBreak ? .blue : themeManager.currentTheme.accentColor)

            HStack(spacing: 16) {
                Button(action: toggleTimer) {
                    Text(isRunning ? "Pause" : "Start")
                        .fontWeight(.semibold)
                        .frame(width: 90, height: 38)
                        .foregroundColor(.white)
                }
                .glassEffect(.regular.tint(themeManager.currentTheme.accentColor), in: .rect(cornerRadius: 10))

                Button(action: resetTimer) {
                    Text("Reset")
                        .fontWeight(.semibold)
                        .frame(width: 90, height: 38)
                        .foregroundColor(themeManager.currentTheme.textColor)
                }
                .glassEffect(.regular.tint(themeManager.currentTheme.cardColor), in: .rect(cornerRadius: 10))
            }

            Text(isBreak ? "5 min break" : "25 min focus session")
                .font(.caption)
                .foregroundColor(themeManager.currentTheme.secondaryTextColor)
        }
        .padding()
        .glassEffect(.regular.tint(themeManager.currentTheme.cardColor), in: .rect(cornerRadius: 16))
        .padding(.horizontal)
        .padding(.top, 8)
    }

    var formattedTime: String {
        let minutes = secondsRemaining / 60
        let seconds = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func toggleTimer() {
        isRunning.toggle()
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if secondsRemaining > 0 {
                    secondsRemaining -= 1
                } else {
                    switchMode()
                }
            }
        } else {
            timer?.invalidate()
        }
    }

    func switchMode() {
        isBreak.toggle()
        secondsRemaining = isBreak ? breakDuration : focusDuration
    }

    func resetTimer() {
        timer?.invalidate()
        isRunning = false
        isBreak = false
        secondsRemaining = focusDuration
    }
}

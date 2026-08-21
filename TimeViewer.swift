import SwiftUI

struct TimerView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var isPresented: Bool

    @State private var elapsedSeconds = 0
    @State private var isRunning = false
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Stopwatch")
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
                .foregroundColor(themeManager.currentTheme.accentColor)

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
        }
        .padding()
        .glassEffect(.regular.tint(themeManager.currentTheme.cardColor), in: .rect(cornerRadius: 16))
        .padding(.horizontal)
        .padding(.top, 8)
    }

    var formattedTime: String {
        let minutes = elapsedSeconds / 60
        let seconds = elapsedSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func toggleTimer() {
        isRunning.toggle()
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                elapsedSeconds += 1
            }
        } else {
            timer?.invalidate()
        }
    }

    func resetTimer() {
        timer?.invalidate()
        isRunning = false
        elapsedSeconds = 0
    }
}

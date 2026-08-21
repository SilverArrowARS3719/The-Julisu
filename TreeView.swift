import SwiftUI

struct TreeView: View {
    var level: Int
    var progress: CGFloat // 0.0 = empty, 1.0 = fully grown
    var pulse: Bool = false
    
    @State private var bounceScale: CGFloat = 1.0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TrunkShape()
                .fill(
                    LinearGradient(
                        colors: [trunkColorLight, trunkColorDark],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: trunkWidth * trunkGrowth, height: trunkHeight * trunkGrowth)
            
            foliageView
                .offset(y: -(trunkHeight * trunkGrowth) * 0.7)
        }
        .frame(height: 200)
        .scaleEffect(bounceScale)
        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: progress)
        .onChange(of: pulse) {
            withAnimation(.interpolatingSpring(stiffness: 300, damping: 8)) {
                bounceScale = 1.15
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.interpolatingSpring(stiffness: 300, damping: 10)) {
                    bounceScale = 1.0
                }
            }
        }
    }
    
    var trunkGrowth: CGFloat {
        min(progress / 0.5, 1.0)
    }
    
    var foliageGrowth: CGFloat {
        progress < 0.5 ? 0 : (progress - 0.5) / 0.5
    }
    
    var trunkWidth: CGFloat {
        switch level {
        case 1: return 36
        case 2: return 52
        case 3: return 70
        default: return 90
        }
    }
    
    var trunkHeight: CGFloat {
        switch level {
        case 1: return 36
        case 2: return 55
        case 3: return 75
        default: return 95
        }
    }
    
    var trunkColorLight: Color {
        switch level {
        case 1: return Color(red: 0.75, green: 0.6, blue: 0.4)
        case 2: return Color(red: 0.65, green: 0.48, blue: 0.3)
        case 3: return Color(red: 0.55, green: 0.38, blue: 0.22)
        default: return Color(red: 0.45, green: 0.3, blue: 0.15)
        }
    }
    
    var trunkColorDark: Color {
        switch level {
        case 1: return Color(red: 0.55, green: 0.4, blue: 0.25)
        case 2: return Color(red: 0.45, green: 0.3, blue: 0.18)
        case 3: return Color(red: 0.35, green: 0.22, blue: 0.1)
        default: return Color(red: 0.28, green: 0.17, blue: 0.08)
        }
    }
    
    var foliageColor: Color {
        switch level {
        case 1: return .mint
        case 2: return .green
        case 3: return Color(red: 0.15, green: 0.55, blue: 0.2)
        case 4: return .teal
        default: return .orange
        }
    }
    
    var clusterOffsets: [(CGFloat, CGFloat, CGFloat)] {
        switch level {
        case 1:
            return [(0, 0, 1.0)]
        case 2:
            return [(-18, 5, 0.85), (18, 5, 0.85), (0, -15, 1.0)]
        case 3:
            return [(-28, 10, 0.8), (28, 10, 0.8), (-14, -18, 0.85), (14, -18, 0.85), (0, -5, 1.0)]
        default:
            return [(-35, 12, 0.75), (35, 12, 0.75), (-20, -20, 0.85), (20, -20, 0.85), (0, -30, 0.9), (0, 0, 1.1)]
        }
    }
    
    var baseSize: CGFloat {
        50 + CGFloat(level) * 14
    }
    
    @ViewBuilder
    var foliageView: some View {
        ZStack {
            ForEach(Array(clusterOffsets.enumerated()), id: \.offset) { index, cluster in
                let (dx, dy, scale) = cluster
                let clusterProgress = min(1.0, max(0.0, foliageGrowth * CGFloat(clusterOffsets.count) - CGFloat(index)))
                Circle()
                    .fill(foliageColor.opacity(0.85 * clusterProgress))
                    .frame(width: baseSize * scale * clusterProgress, height: baseSize * scale * clusterProgress)
                    .offset(x: dx, y: dy)
            }
        }
    }
}

struct TrunkShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let taperFactor: CGFloat = 0.65
        let topInset = rect.width * (1 - taperFactor) / 2
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - topInset, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + topInset, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

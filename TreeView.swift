import SwiftUI

struct TreeView: View {
    var level: Int

    var body: some View {
        ZStack(alignment: .bottom) {
            // Trunk
            Rectangle()
                .fill(trunkColor)
                .frame(width: trunkWidth, height: trunkHeight)

            // Foliage
            foliageView
                .offset(y: -trunkHeight * 0.6)
        }
        .frame(height: 180)
    }

    var trunkWidth: CGFloat {
        level == 1 ? 6 : 14
    }

    var trunkHeight: CGFloat {
        switch level {
        case 1: return 30
        case 2: return 50
        case 3: return 70
        default: return 90
        }
    }

    var trunkColor: Color {
        switch level {
        case 1: return .brown.opacity(0.6)
        case 2: return .brown
        case 3: return Color(red: 0.5, green: 0.3, blue: 0.1)
        default: return Color(red: 0.4, green: 0.25, blue: 0.1)
        }
    }

    var foliageColor: Color {
        switch level {
        case 1:
            return .mint
        case 2:
            return .green
        case 3:
            return Color(red: 0.1, green: 0.5, blue: 0.2)
        case 4:
            return .teal
        default:
            return .orange
        }
    }

    @ViewBuilder
    var foliageView: some View {
        switch level {
        case 1:
            // Sapling: single small circle
            Circle()
                .fill(foliageColor.opacity(0.7))
                .frame(width: 40, height: 40)

        case 2:
            // Young tree: two overlapping circles
            ZStack {
                Circle().fill(foliageColor.opacity(0.8)).frame(width: 60, height: 60).offset(x: -15)
                Circle().fill(foliageColor.opacity(0.8)).frame(width: 60, height: 60).offset(x: 15)
            }

        case 3:
            // Mature tree: three-circle cluster
            ZStack {
                Circle().fill(foliageColor).frame(width: 70, height: 70).offset(x: -20, y: 10)
                Circle().fill(foliageColor).frame(width: 70, height: 70).offset(x: 20, y: 10)
                Circle().fill(foliageColor).frame(width: 80, height: 80).offset(y: -15)
            }

        case 4:
            // Flowering tree: teal foliage + pink blossoms
            ZStack {
                Circle().fill(foliageColor).frame(width: 70, height: 70).offset(x: -20, y: 10)
                Circle().fill(foliageColor).frame(width: 70, height: 70).offset(x: 20, y: 10)
                Circle().fill(foliageColor).frame(width: 80, height: 80).offset(y: -15)

                ForEach(0..<8, id: \.self) { i in
                    Circle()
                        .fill(Color.pink)
                        .frame(width: 8, height: 8)
                        .offset(
                            x: CGFloat.random(in: -50...50),
                            y: CGFloat.random(in: -50...30)
                        )
                }
            }

        default:
            // Ancient tree: golden/orange canopy
            ZStack {
                Circle().fill(foliageColor.opacity(0.85)).frame(width: 90, height: 90).offset(x: -25, y: 10)
                Circle().fill(foliageColor.opacity(0.85)).frame(width: 90, height: 90).offset(x: 25, y: 10)
                Circle().fill(foliageColor).frame(width: 100, height: 100).offset(y: -20)
            }
        }
    }
}

import SwiftUI

struct ScannerView: View {
    @Environment(\.dismiss) private var dismiss
    let onDetected: (String) -> Void

    private let viewfinderSize: CGFloat = 260
    private let mockNames = ["Milk", "Eggs", "Bread", "Butter", "Yogurt", "Cheese", "Carrots", "Chicken"]

    @State private var scanOffset: CGFloat = -110
    @State private var detected: String?

    var body: some View {
        ZStack {
            background.ignoresSafeArea()

            VStack {
                topBar
                Spacer()
                viewfinder
                Spacer()
                if detected == nil {
                    Text("Point at a food label or barcode")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.6))
                        .padding(.bottom, 80)
                } else {
                    Color.clear.frame(height: 80 + 18)
                }
            }

            if let name = detected {
                detectedOverlay(name: name)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .onAppear(perform: start)
    }

    private var background: some View {
        RadialGradient(
            colors: [Color(red: 0.04, green: 0.10, blue: 0.20), .black],
            center: .center,
            startRadius: 60,
            endRadius: 480
        )
    }

    private var topBar: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(.white.opacity(0.15), in: Circle())
            }
            Spacer()
            Text("Scan food")
                .font(.headline)
                .foregroundStyle(.white)
            Spacer()
            Color.clear.frame(width: 40, height: 40)
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
    }

    private var viewfinder: some View {
        ZStack {
            CornerBracketsShape()
                .stroke(.cyan, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .shadow(color: .cyan.opacity(0.5), radius: 8)

            if detected == nil {
                Rectangle()
                    .fill(LinearGradient(colors: [.clear, .cyan, .clear], startPoint: .leading, endPoint: .trailing))
                    .frame(width: viewfinderSize - 40, height: 2)
                    .shadow(color: .cyan, radius: 10)
                    .offset(y: scanOffset)
            }
        }
        .frame(width: viewfinderSize, height: viewfinderSize)
    }

    private func detectedOverlay(name: String) -> some View {
        VStack(spacing: 14) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(.green)
            Text("Detected")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
            Text(name)
                .font(.title.weight(.bold))
                .foregroundStyle(.white)
        }
        .padding(28)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
    }

    private func start() {
        withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
            scanOffset = 110
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            let name = mockNames.randomElement() ?? "Milk"
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                detected = name
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                onDetected(name)
            }
        }
    }
}

private struct CornerBracketsShape: Shape {
    var bracketLength: CGFloat = 32

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let len = bracketLength
        let w = rect.width
        let h = rect.height

        path.move(to: CGPoint(x: 0, y: len))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: len, y: 0))

        path.move(to: CGPoint(x: w - len, y: 0))
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: len))

        path.move(to: CGPoint(x: w, y: h - len))
        path.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: w - len, y: h))

        path.move(to: CGPoint(x: len, y: h))
        path.addLine(to: CGPoint(x: 0, y: h))
        path.addLine(to: CGPoint(x: 0, y: h - len))

        return path
    }
}

#Preview {
    ScannerView { name in
        print("Detected: \(name)")
    }
}

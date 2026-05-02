import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        header
                        statsRow
                        quickActions
                        expiringSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 40)
                }
            }
            .toolbar(.hidden)
        }
    }

    private var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.04, green: 0.10, blue: 0.28),
                Color(red: 0.00, green: 0.35, blue: 0.55),
                Color(red: 0.10, green: 0.55, blue: 0.70)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Welcome back")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.75))
                Text("Poseidon")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                Text("Master of your fridge")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }
            Spacer()
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 38))
                .foregroundStyle(.white.opacity(0.85))
        }
    }

    private var statsRow: some View {
        HStack(spacing: 12) {
            StatCard(icon: "shippingbox.fill", value: "0", label: "Items", tint: .cyan)
            StatCard(icon: "exclamationmark.triangle.fill", value: "0", label: "Expiring", tint: .orange)
            StatCard(icon: "leaf.fill", value: "0", label: "Fresh", tint: .green)
        }
    }

    private var quickActions: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Add food")
                .font(.headline)
                .foregroundStyle(.white)

            HStack(spacing: 12) {
                ActionButton(icon: "square.and.pencil", title: "Manual") {}
                ActionButton(icon: "camera.viewfinder", title: "Scan") {}
            }
        }
    }

    private var expiringSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Expiring soon")
                    .font(.headline)
                    .foregroundStyle(.white)
                Spacer()
                Text("See all")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
            }

            VStack(spacing: 12) {
                Image(systemName: "snowflake")
                    .font(.system(size: 44))
                    .foregroundStyle(.white.opacity(0.55))
                Text("Your fridge is empty")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.85))
                Text("Tap Manual or Scan to add your first item")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.55))
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 36)
            .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
    }
}

private struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    let tint: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(tint)
            Text(value)
                .font(.title.weight(.bold))
                .foregroundStyle(.white)
            Text(label)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

private struct ActionButton: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(title).fontWeight(.semibold)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(.white.opacity(0.18), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView()
}

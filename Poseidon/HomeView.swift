import SwiftUI

struct HomeView: View {
    @Environment(FoodStore.self) private var store

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
                        recipesSection
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
            NavigationLink {
                FoodListView(filter: .all)
            } label: {
                StatCard(
                    icon: "shippingbox.fill",
                    value: "\(store.items.count)",
                    label: "Items",
                    tint: .cyan
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                FoodListView(filter: .expiring)
            } label: {
                StatCard(
                    icon: "exclamationmark.triangle.fill",
                    value: "\(store.expiringSoon.count)",
                    label: "Expiring",
                    tint: .orange
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                FoodListView(filter: .fresh)
            } label: {
                StatCard(
                    icon: "leaf.fill",
                    value: "\(store.fresh.count)",
                    label: "Fresh",
                    tint: .green
                )
            }
            .buttonStyle(.plain)
        }
    }

    private var quickActions: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Add food")
                .font(.headline)
                .foregroundStyle(.white)

            HStack(spacing: 12) {
                NavigationLink {
                    AddFoodView()
                } label: {
                    ActionPill(icon: "square.and.pencil", title: "Manual")
                }
                .buttonStyle(.plain)

                ActionButton(icon: "camera.viewfinder", title: "Scan") {}
            }
        }
    }

    private var recipesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recipe ideas")
                .font(.headline)
                .foregroundStyle(.white)

            NavigationLink {
                RecipeView()
            } label: {
                HStack(spacing: 14) {
                    Image(systemName: "fork.knife.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(.cyan)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Cook with your fridge")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white)
                        Text("See what you can make tonight")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.6))
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white.opacity(0.5))
                }
                .padding()
                .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .buttonStyle(.plain)
        }
    }

    private var expiringSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Expiring soon")
                    .font(.headline)
                    .foregroundStyle(.white)

                Spacer()

                NavigationLink {
                    FoodListView(filter: .expiring)
                } label: {
                    Text("See all")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .buttonStyle(.plain)
            }

            if store.expiringSoon.isEmpty {
                expiringEmptyState
            } else {
                VStack(spacing: 12) {
                    ForEach(store.expiringSoon.prefix(2)) { item in
                        NavigationLink {
                            AddFoodView(editing: item)
                        } label: {
                            FoodRow(item: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private var expiringEmptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: "snowflake")
                .font(.system(size: 40))
                .foregroundStyle(.white.opacity(0.5))
            Text("Nothing expiring soon")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.85))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
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

private struct ActionPill: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
            Text(title).fontWeight(.semibold)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(.white.opacity(0.18), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

private struct ActionButton: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ActionPill(icon: icon, title: title)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView()
        .environment(FoodStore())
}

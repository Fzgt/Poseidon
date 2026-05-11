import SwiftUI

struct FoodListView: View {
    enum Filter {
        case all
        case expiring
        case fresh

        var title: String {
            switch self {
            case .all: return "All items"
            case .expiring: return "Expiring soon"
            case .fresh: return "Fresh items"
            }
        }

        var heading: String {
            switch self {
            case .all: return "Everything in your fridge"
            case .expiring: return "Use these first"
            case .fresh: return "Plenty of time"
            }
        }

        var subheading: String {
            switch self {
            case .all: return "Sorted by expiry date"
            case .expiring: return "Items expiring within the next 3 days"
            case .fresh: return "Items with more than 3 days left"
            }
        }

        var emptyIcon: String {
            switch self {
            case .all: return "shippingbox"
            case .expiring: return "checkmark.seal.fill"
            case .fresh: return "leaf"
            }
        }

        var emptyHeadline: String {
            switch self {
            case .all: return "Your fridge is empty"
            case .expiring: return "Nothing expiring soon"
            case .fresh: return "No fresh items yet"
            }
        }

        var emptyMessage: String {
            switch self {
            case .all: return "Tap Manual or Scan on the home page to add food"
            case .expiring: return "Your fridge looks fresh"
            case .fresh: return "Add items with longer shelf life"
            }
        }
    }

    let filter: Filter

    @Environment(FoodStore.self) private var store

    private var items: [FoodItem] {
        switch filter {
        case .all:
            return store.items.sorted { $0.daysUntilExpiry < $1.daysUntilExpiry }
        case .expiring:
            return store.expiringSoon
        case .fresh:
            return store.fresh.sorted { $0.daysUntilExpiry < $1.daysUntilExpiry }
        }
    }

    var body: some View {
        ZStack {
            backgroundGradient.ignoresSafeArea()

            List {
                header
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 12, trailing: 20))

                if items.isEmpty {
                    emptyState
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                } else {
                    ForEach(items) { item in
                        NavigationLink {
                            AddFoodView(editing: item)
                        } label: {
                            FoodRow(item: item)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                store.remove(item)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle(filter.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(filter.heading)
                .font(.title2.weight(.bold))
                .foregroundStyle(.white)
            Text(filter.subheading)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: filter.emptyIcon)
                .font(.system(size: 48))
                .foregroundStyle(.white.opacity(0.55))
            Text(filter.emptyHeadline)
                .foregroundStyle(.white.opacity(0.85))
            Text(filter.emptyMessage)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.55))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
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
}

struct FoodRow: View {
    let item: FoodItem

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                if !quantityText.isEmpty {
                    Text(quantityText)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.6))
                }
            }
            Spacer()
            statusPill
        }
        .padding()
        .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var quantityText: String {
        let unit = item.unit.trimmingCharacters(in: .whitespaces)
        if unit.isEmpty {
            return item.quantity > 1 ? "×\(item.quantity)" : ""
        }
        return "\(item.quantity) \(unit)"
    }

    private var statusPill: some View {
        Text(item.statusLabel)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(pillColor, in: Capsule())
    }

    private var pillColor: Color {
        switch item.daysUntilExpiry {
        case ..<0: return .red.opacity(0.65)
        case 0: return .red.opacity(0.55)
        case 1: return .orange.opacity(0.6)
        case 2...3: return .yellow.opacity(0.5)
        default: return .white.opacity(0.20)
        }
    }
}

#Preview("All") {
    NavigationStack {
        FoodListView(filter: .all)
            .environment(FoodStore())
    }
}

#Preview("Expiring") {
    NavigationStack {
        FoodListView(filter: .expiring)
            .environment(FoodStore())
    }
}

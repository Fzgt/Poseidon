import Foundation

struct FoodItem: Identifiable, Hashable {
    let id: UUID
    var name: String
    var quantity: Int
    var unit: String
    var expiryDate: Date

    init(
        id: UUID = UUID(),
        name: String,
        quantity: Int = 1,
        unit: String = "",
        expiryDate: Date
    ) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.expiryDate = expiryDate
    }
}

extension FoodItem {
    var daysUntilExpiry: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let target = calendar.startOfDay(for: expiryDate)
        return calendar.dateComponents([.day], from: today, to: target).day ?? 0
    }

    var statusLabel: String {
        switch daysUntilExpiry {
        case ..<0: return "Expired"
        case 0: return "Today"
        case 1: return "Tomorrow"
        case let d: return "In \(d) days"
        }
    }

    var isExpiringSoon: Bool { daysUntilExpiry <= 3 }
}

import Foundation
import Observation

@Observable
final class FoodStore {
    var items: [FoodItem]

    init(items: [FoodItem] = FoodStore.sampleItems) {
        self.items = items
    }

    func add(_ item: FoodItem) {
        items.append(item)
    }

    func remove(_ item: FoodItem) {
        items.removeAll { $0.id == item.id }
    }

    func update(_ item: FoodItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
        }
    }

    var expiringSoon: [FoodItem] {
        items
            .filter { $0.isExpiringSoon }
            .sorted { $0.daysUntilExpiry < $1.daysUntilExpiry }
    }

    var fresh: [FoodItem] {
        items.filter { !$0.isExpiringSoon && $0.daysUntilExpiry >= 0 }
    }
}

extension FoodStore {
    static var sampleItems: [FoodItem] {
        let calendar = Calendar.current
        func inDays(_ n: Int) -> Date {
            calendar.date(byAdding: .day, value: n, to: Date()) ?? Date()
        }
        return [
            FoodItem(name: "Milk", quantity: 1, unit: "L", expiryDate: inDays(0)),
            FoodItem(name: "Eggs", quantity: 6, unit: "pcs", expiryDate: inDays(1)),
            FoodItem(name: "Bread", quantity: 1, unit: "loaf", expiryDate: inDays(2)),
            FoodItem(name: "Yogurt", quantity: 4, unit: "cups", expiryDate: inDays(3)),
            FoodItem(name: "Chicken", quantity: 500, unit: "g", expiryDate: inDays(3)),
            FoodItem(name: "Carrots", quantity: 5, unit: "pcs", expiryDate: inDays(10)),
            FoodItem(name: "Rice", quantity: 1, unit: "kg", expiryDate: inDays(180))
        ]
    }
}

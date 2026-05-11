import Foundation

struct Recipe: Identifiable {
    let id = UUID()
    var name: String
    var ingredients: [String]
    var symbol: String
}

extension Recipe {
    static let library: [Recipe] = [
        Recipe(
            name: "Milk Pasta",
            ingredients: ["Milk", "Pasta", "Butter", "Parmesan", "Garlic"],
            symbol: "fork.knife"
        ),
        Recipe(
            name: "Omelette",
            ingredients: ["Eggs", "Butter", "Cheese", "Salt", "Pepper"],
            symbol: "frying.pan.fill"
        ),
        Recipe(
            name: "Vanilla Cake",
            ingredients: ["Flour", "Sugar", "Eggs", "Milk", "Butter", "Vanilla"],
            symbol: "birthday.cake.fill"
        ),
        Recipe(
            name: "Toast",
            ingredients: ["Bread", "Butter", "Jam"],
            symbol: "flame.fill"
        ),
        Recipe(
            name: "Yogurt Parfait",
            ingredients: ["Yogurt", "Honey", "Granola", "Berries"],
            symbol: "leaf.fill"
        ),
        Recipe(
            name: "Chicken Stir Fry",
            ingredients: ["Chicken", "Carrots", "Onion", "Soy sauce", "Garlic", "Oil"],
            symbol: "fish.fill"
        ),
        Recipe(
            name: "French Toast",
            ingredients: ["Bread", "Eggs", "Milk", "Butter", "Cinnamon", "Sugar"],
            symbol: "sun.max.fill"
        ),
        Recipe(
            name: "Fried Rice",
            ingredients: ["Rice", "Eggs", "Carrots", "Onion", "Soy sauce", "Garlic"],
            symbol: "takeoutbag.and.cup.and.straw.fill"
        ),
        Recipe(
            name: "Chicken Soup",
            ingredients: ["Chicken", "Carrots", "Onion", "Salt", "Pepper"],
            symbol: "drop.fill"
        )
    ]
}

import Foundation

struct Recipe: Identifiable {
    let id = UUID()
    var name: String
    var ingredients: [String]
    var symbol: String
}

extension Recipe {
    static let library: [Recipe] = [
        Recipe(name: "Milk Pasta", ingredients: ["Milk"], symbol: "fork.knife"),
        Recipe(name: "Omelette", ingredients: ["Eggs"], symbol: "frying.pan.fill"),
        Recipe(name: "Vanilla Cake", ingredients: ["Milk", "Eggs"], symbol: "birthday.cake.fill"),
        Recipe(name: "Toast", ingredients: ["Bread"], symbol: "flame.fill"),
        Recipe(name: "Yogurt Parfait", ingredients: ["Yogurt"], symbol: "leaf.fill"),
        Recipe(name: "Chicken Stir Fry", ingredients: ["Chicken", "Carrots"], symbol: "fish.fill"),
        Recipe(name: "French Toast", ingredients: ["Bread", "Eggs", "Milk"], symbol: "sun.max.fill")
    ]
}

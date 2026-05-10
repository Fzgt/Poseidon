import Foundation

struct RecipeRecommender {
    func recommend(items: [FoodItem], from library: [Recipe]) -> [RecipeScore] {
        library
            .compactMap { recipe in
                let matched = items.filter { item in
                    recipe.ingredients.contains { $0.lowercased() == item.name.lowercased() }
                }
                guard !matched.isEmpty else { return nil }

                let score = matched.reduce(0.0) { $0 + priority(for: $1) }
                return RecipeScore(
                    recipe: recipe,
                    score: score,
                    matchedIngredients: matched.map(\.name)
                )
            }
            .sorted { $0.score > $1.score }
    }

    private func priority(for item: FoodItem) -> Double {
        let days = item.daysUntilExpiry
        if days <= 0 { return 100 }
        return 1.0 / Double(days)
    }
}

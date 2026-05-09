import Foundation

struct RecipeScore: Identifiable {

    let id = UUID()

    let recipe: Recipe

    let score: Double

    let matchedIngredients: [String]
}

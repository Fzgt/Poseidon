import Foundation

class RecipeRecommender {

    func recommendRecipes(
        ingredients: [Ingredient],
        recipes: [Recipe]
    ) -> [RecipeScore] {

        var scoredRecipes: [RecipeScore] = []

        for recipe in recipes {

            var score: Double = 0
            var matchedIngredients: [String] = []

            for ingredient in ingredients {

                if recipe.ingredients.contains(where: {
                    $0.lowercased() == ingredient.name.lowercased()
                }) {

                    let priority = ingredientPriority(
                        for: ingredient
                    )

                    score += priority

                    matchedIngredients.append(
                        ingredient.name
                    )
                }
            }

            if score > 0 {

                scoredRecipes.append(

                    RecipeScore(
                        recipe: recipe,
                        score: score,
                        matchedIngredients: matchedIngredients
                    )
                )
            }
        }

        return scoredRecipes.sorted {
            $0.score > $1.score
        }
    }

    func ingredientPriority(
        for ingredient: Ingredient
    ) -> Double {

        let days = remainingDays(
            until: ingredient.expiryDate
        )

        if days == 0 {
            return 100
        }

        return 1.0 / Double(days)
    }

    func remainingDays(
        until expiryDate: Date
    ) -> Int {

        let days = Calendar.current.dateComponents(
            [.day],
            from: Date(),
            to: expiryDate
        ).day ?? 0

        return max(days, 0)
    }
}

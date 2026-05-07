import Foundation

class RecipeViewModel: ObservableObject {

    @Published var recommendedRecipes: [RecipeScore] = []

    func loadRecommendations(
        ingredient: String
    ) {

        let ingredients = [

            Ingredient(
                name: ingredient,
                quantity: 1,
                unit: "",
                expiryDate: Date()
            )
        ]

        let recipes = [

            Recipe(
                name: "Milk Pasta",
                ingredients: ["Milk"],
                imageName: "pasta"
            ),

            Recipe(
                name: "Omelette",
                ingredients: ["Eggs"],
                imageName: "omelette"
            ),

            Recipe(
                name: "Cake",
                ingredients: ["Milk", "Eggs"],
                imageName: "cake"
            ),

            Recipe(
                name: "Toast",
                ingredients: ["Bread"],
                imageName: "toast"
            )
        ]

        let recommender = RecipeRecommender()

        recommendedRecipes = recommender.recommendRecipes(
            ingredients: ingredients,
            recipes: recipes
        )
    }
}

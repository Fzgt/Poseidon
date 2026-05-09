import SwiftUI

struct RecipeCardView: View {

    let recipeScore: RecipeScore

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Image(recipeScore.recipe.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .clipped()
                .cornerRadius(14)

            Text(recipeScore.recipe.name)
                .font(.title2)
                .bold()

            Text("Matched Ingredients")
                .font(.headline)

            Text(
                recipeScore.matchedIngredients.joined(
                    separator: ", "
                )
            )
            .foregroundColor(.green)

            Text(
                "Recommendation Score: \(recipeScore.score, specifier: "%.2f")"
            )
            .foregroundColor(.orange)

            VStack(alignment: .leading) {

                Text("Why recommended?")
                    .font(.headline)

                Text(
                    "This recipe uses ingredients that are expiring soon."
                )
                .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.white.opacity(0.12))
        .cornerRadius(18)
    }
}

#Preview {

    RecipeCardView(

        recipeScore: RecipeScore(

            recipe: Recipe(
                name: "Milk Pasta",
                ingredients: ["Milk"],
                imageName: "pasta"
            ),

            score: 1.0,

            matchedIngredients: ["Milk"]
        )
    )
}

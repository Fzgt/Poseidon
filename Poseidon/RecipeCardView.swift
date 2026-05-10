import SwiftUI

struct RecipeCardView: View {
    let recipeScore: RecipeScore

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: recipeScore.recipe.symbol)
                .font(.system(size: 28))
                .foregroundStyle(.cyan)
                .frame(width: 56, height: 56)
                .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 14, style: .continuous))

            VStack(alignment: .leading, spacing: 6) {
                Text(recipeScore.recipe.name)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("Uses \(recipeScore.matchedIngredients.joined(separator: ", "))")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
                    .lineLimit(2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.white.opacity(0.4))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [Color(red: 0.04, green: 0.10, blue: 0.28), Color(red: 0.10, green: 0.55, blue: 0.70)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()

        RecipeCardView(
            recipeScore: RecipeScore(
                recipe: Recipe.library[0],
                score: 100,
                matchedIngredients: ["Milk"]
            )
        )
        .padding()
    }
}

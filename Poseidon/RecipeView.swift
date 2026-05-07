import SwiftUI

struct RecipeView: View {

    let selectedIngredient: String

    @StateObject var viewModel = RecipeViewModel()

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    Color(red: 0.04, green: 0.10, blue: 0.28),
                    Color(red: 0.00, green: 0.35, blue: 0.55),
                    Color(red: 0.10, green: 0.55, blue: 0.70)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {

                VStack(spacing: 20) {

                    Text("Recipes using \(selectedIngredient)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    ForEach(viewModel.recommendedRecipes) { item in

                        RecipeCardView(
                            recipeScore: item
                        )
                    }
                }
                .padding()
            }
        }
        .onAppear {

            viewModel.loadRecommendations(
                ingredient: selectedIngredient
            )
        }
    }
}

#Preview {
    RecipeView(selectedIngredient: "Milk")
}

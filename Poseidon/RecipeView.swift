import SwiftUI

struct RecipeView: View {
    @Environment(FoodStore.self) private var store

    private var scores: [RecipeScore] {
        RecipeRecommender().recommend(items: store.items, from: Recipe.library)
    }

    var body: some View {
        ZStack {
            backgroundGradient.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    header

                    if scores.isEmpty {
                        emptyState
                    } else {
                        ForEach(scores) { score in
                            RecipeCardView(recipeScore: score)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Recipes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Cook with what you have")
                .font(.title2.weight(.bold))
                .foregroundStyle(.white)
            Text("Sorted by what's expiring soonest")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
        }
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 48))
                .foregroundStyle(.white.opacity(0.5))
            Text("No recipes match your fridge yet")
                .foregroundStyle(.white.opacity(0.8))
            Text("Add more food items and check back")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.04, green: 0.10, blue: 0.28),
                Color(red: 0.00, green: 0.35, blue: 0.55),
                Color(red: 0.10, green: 0.55, blue: 0.70)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    NavigationStack {
        RecipeView()
            .environment(FoodStore())
    }
}

import SwiftUI

struct RecipeDetailView: View {
    let recipeScore: RecipeScore

    @Environment(FoodStore.self) private var store

    private var matchedItems: [FoodItem] {
        let matched = Set(recipeScore.matchedIngredients.map { $0.lowercased() })
        return store.items
            .filter { matched.contains($0.name.lowercased()) }
            .sorted { $0.daysUntilExpiry < $1.daysUntilExpiry }
    }

    private var missingIngredients: [String] {
        let matched = Set(recipeScore.matchedIngredients.map { $0.lowercased() })
        return recipeScore.recipe.ingredients.filter { !matched.contains($0.lowercased()) }
    }

    var body: some View {
        ZStack {
            backgroundGradient.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    hero
                    haveSection
                    if !missingIngredients.isEmpty {
                        needSection
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle(recipeScore.recipe.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var hero: some View {
        HStack(spacing: 16) {
            Image(systemName: recipeScore.recipe.symbol)
                .font(.system(size: 44))
                .foregroundStyle(.cyan)
                .frame(width: 80, height: 80)
                .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 18, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(recipeScore.recipe.name)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.white)
                Text("\(recipeScore.recipe.ingredients.count) ingredients · \(recipeScore.matchedIngredients.count) in fridge")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
            }

            Spacer()
        }
    }

    private var haveSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("In your fridge", systemImage: "checkmark.circle.fill", tint: .green)
            VStack(spacing: 12) {
                ForEach(matchedItems) { item in
                    FoodRow(item: item)
                }
            }
        }
    }

    private var needSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("Still need", systemImage: "cart.fill", tint: .orange)
            VStack(spacing: 10) {
                ForEach(missingIngredients, id: \.self) { name in
                    HStack(spacing: 12) {
                        Image(systemName: "circle")
                            .foregroundStyle(.white.opacity(0.5))
                        Text(name)
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(.white.opacity(0.85))
                        Spacer()
                    }
                    .padding()
                    .background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
            }
        }
    }

    private func sectionHeader(_ title: String, systemImage: String, tint: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .foregroundStyle(tint)
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
        }
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
        RecipeDetailView(
            recipeScore: RecipeScore(
                recipe: Recipe.library[2],
                score: 100,
                matchedIngredients: ["Milk", "Eggs"]
            )
        )
        .environment(FoodStore())
    }
}

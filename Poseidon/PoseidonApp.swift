import SwiftUI

@main
struct PoseidonApp: App {
    @State private var foodStore = FoodStore()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(foodStore)
        }
    }
}

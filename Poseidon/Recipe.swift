import Foundation

struct Recipe: Identifiable {

    let id = UUID()

    var name: String

    var ingredients: [String]

    var imageName: String
}

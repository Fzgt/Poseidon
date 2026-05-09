import SwiftUI

struct AddFoodView: View {

    @State private var itemName = ""
    @State private var expiryDate = Date()

    var body: some View {

        NavigationView {

            VStack(spacing: 20) {

                Text("Add Food")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                // Item Name
                VStack(alignment: .leading) {

                    Text("Item Name:")
                        .font(.headline)

                    TextField("Enter food name", text: $itemName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)

                // Expiry Date
                VStack(alignment: .leading) {

                    Text("Expiry Date:")
                        .font(.headline)

                    DatePicker(
                        "",
                        selection: $expiryDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                }
                .padding(.horizontal)

                // Add Button
                Button(action: {

                    print("Food Added")

                }) {

                    Text("Add To My Fridge")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                Spacer()

                // Bottom Navigation
                HStack(spacing: 40) {

                    NavigationLink(destination: HomeView()) {

                        VStack {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    }

                    NavigationLink(destination: ExpiringView()) {

                        VStack {
                            Image(systemName: "refrigerator.fill")
                            Text("Fridge")
                        }
                    }

                    NavigationLink(destination: HomeView()) {

                        VStack {
                            Image(systemName: "book.fill")
                            Text("Recipe")
                        }
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    AddFoodView()
}

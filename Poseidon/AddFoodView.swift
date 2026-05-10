import SwiftUI

struct AddFoodView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(FoodStore.self) private var store

    @State private var name: String = ""
    @State private var quantity: Int = 1
    @State private var unit: String = ""
    @State private var expiryDate: Date = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()

    private var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var canSave: Bool { !trimmedName.isEmpty }

    var body: some View {
        ZStack {
            backgroundGradient.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    header

                    nameField
                    quantityField
                    expirySection

                    saveButton
                        .padding(.top, 8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Add to fridge")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("New item")
                .font(.title2.weight(.bold))
                .foregroundStyle(.white)
            Text("Track what's in your fridge before it spoils")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
        }
    }

    private var nameField: some View {
        FieldCard(label: "Name") {
            TextField("", text: $name, prompt: Text("e.g. Milk").foregroundColor(.white.opacity(0.45)))
                .foregroundStyle(.white)
                .tint(.cyan)
                .autocorrectionDisabled()
        }
    }

    private var quantityField: some View {
        FieldCard(label: "Quantity") {
            HStack {
                Stepper(value: $quantity, in: 1...999) {
                    HStack(spacing: 8) {
                        Text("\(quantity)")
                            .font(.headline)
                            .foregroundStyle(.white)
                        TextField(
                            "",
                            text: Binding(
                                get: { unit },
                                set: { unit = $0 }
                            ),
                            prompt: Text("unit").foregroundColor(.white.opacity(0.45))
                        )
                        .foregroundStyle(.white.opacity(0.85))
                        .tint(.cyan)
                        .autocorrectionDisabled()
                    }
                }
                .labelsHidden()
                .tint(.cyan)
            }
        }
    }

    private var expirySection: some View {
        FieldCard(label: "Expires on") {
            DatePicker(
                "",
                selection: $expiryDate,
                in: Calendar.current.startOfDay(for: Date())...,
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .labelsHidden()
            .colorScheme(.dark)
            .tint(.cyan)
        }
    }

    private var saveButton: some View {
        Button(action: save) {
            Text("Add to fridge")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    canSave
                        ? LinearGradient(colors: [.cyan, .blue], startPoint: .leading, endPoint: .trailing)
                        : LinearGradient(colors: [.white.opacity(0.2), .white.opacity(0.2)], startPoint: .leading, endPoint: .trailing),
                    in: RoundedRectangle(cornerRadius: 14, style: .continuous)
                )
        }
        .disabled(!canSave)
    }

    private func save() {
        let item = FoodItem(
            name: trimmedName,
            quantity: quantity,
            unit: unit.trimmingCharacters(in: .whitespaces),
            expiryDate: expiryDate
        )
        store.add(item)
        dismiss()
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

private struct FieldCard<Content: View>: View {
    let label: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.85))
            content()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
    }
}

#Preview {
    NavigationStack {
        AddFoodView()
            .environment(FoodStore())
    }
}

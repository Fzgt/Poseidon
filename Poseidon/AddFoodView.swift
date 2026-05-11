import SwiftUI

struct AddFoodView: View {
    let editing: FoodItem?

    @Environment(\.dismiss) private var dismiss
    @Environment(FoodStore.self) private var store

    @State private var name: String
    @State private var quantity: Int
    @State private var unit: String
    @State private var expiryDate: Date

    init(editing: FoodItem? = nil) {
        self.editing = editing
        _name = State(initialValue: editing?.name ?? "")
        _quantity = State(initialValue: editing?.quantity ?? 1)
        _unit = State(initialValue: editing?.unit ?? "")
        _expiryDate = State(
            initialValue: editing?.expiryDate
                ?? Calendar.current.date(byAdding: .day, value: 7, to: Date())
                ?? Date()
        )
    }

    private var isEditing: Bool { editing != nil }

    private var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var canSave: Bool { !trimmedName.isEmpty && quantity >= 1 }

    var body: some View {
        ZStack {
            backgroundGradient.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    header

                    nameField
                    quantityField
                    unitField
                    expirySection

                    saveButton
                        .padding(.top, 8)

                    if isEditing {
                        deleteButton
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle(isEditing ? "Edit item" : "Add to fridge")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(isEditing ? "Update item" : "New item")
                .font(.title2.weight(.bold))
                .foregroundStyle(.white)
            Text(isEditing
                 ? "Change details or remove from fridge"
                 : "Track what's in your fridge before it spoils")
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
            HStack(spacing: 16) {
                stepperButton(systemName: "minus", disabled: quantity <= 1) {
                    quantity = max(1, quantity - 1)
                }

                TextField(
                    "",
                    value: $quantity,
                    format: .number
                )
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .font(.title3.weight(.bold))
                .foregroundStyle(.white)
                .tint(.cyan)
                .frame(minWidth: 60)

                stepperButton(systemName: "plus", disabled: quantity >= 999) {
                    quantity = min(999, quantity + 1)
                }

                Spacer()
            }
        }
    }

    private var unitField: some View {
        FieldCard(label: "Unit (optional)") {
            TextField(
                "",
                text: $unit,
                prompt: Text("e.g. L, pcs, kg").foregroundColor(.white.opacity(0.45))
            )
            .foregroundStyle(.white)
            .tint(.cyan)
            .autocorrectionDisabled()
        }
    }

    private var expirySection: some View {
        VStack(alignment: .leading, spacing: 6) {
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

            HStack(spacing: 6) {
                Image(systemName: willBeExpiringSoon ? "exclamationmark.triangle.fill" : "info.circle")
                    .font(.caption2)
                    .foregroundStyle(willBeExpiringSoon ? .orange : .white.opacity(0.55))
                Text(expiryHintText)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.65))
            }
            .padding(.leading, 4)
        }
    }

    private var willBeExpiringSoon: Bool {
        let calendar = Calendar.current
        let days = calendar.dateComponents(
            [.day],
            from: calendar.startOfDay(for: Date()),
            to: calendar.startOfDay(for: expiryDate)
        ).day ?? 0
        return days <= 3
    }

    private var expiryHintText: String {
        willBeExpiringSoon
            ? "This item will appear in Expiring soon"
            : "This item will appear in Fresh — Expiring soon shows items within 3 days"
    }

    private var saveButton: some View {
        Button(action: save) {
            Text(isEditing ? "Save changes" : "Add to fridge")
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

    private var deleteButton: some View {
        Button(role: .destructive, action: delete) {
            HStack(spacing: 8) {
                Image(systemName: "trash")
                Text("Delete from fridge").fontWeight(.semibold)
            }
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(.red.opacity(0.15), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
    }

    private func stepperButton(
        systemName: String,
        disabled: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.headline.weight(.bold))
                .foregroundStyle(disabled ? Color.white.opacity(0.4) : .white)
                .frame(width: 40, height: 40)
                .background(.white.opacity(0.18), in: Circle())
        }
        .disabled(disabled)
    }

    private func save() {
        let trimmedUnit = unit.trimmingCharacters(in: .whitespaces)
        if let editing {
            store.update(
                FoodItem(
                    id: editing.id,
                    name: trimmedName,
                    quantity: quantity,
                    unit: trimmedUnit,
                    expiryDate: expiryDate
                )
            )
        } else {
            store.add(
                FoodItem(
                    name: trimmedName,
                    quantity: quantity,
                    unit: trimmedUnit,
                    expiryDate: expiryDate
                )
            )
        }
        dismiss()
    }

    private func delete() {
        if let editing {
            store.remove(editing)
        }
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

#Preview("Add") {
    NavigationStack {
        AddFoodView()
            .environment(FoodStore())
    }
}

#Preview("Edit") {
    NavigationStack {
        AddFoodView(editing: FoodStore.sampleItems[0])
            .environment(FoodStore())
    }
}

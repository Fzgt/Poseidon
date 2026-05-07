//
//  ExpiringView.swift
//  Poseidon
//
//  Created by Jihye Park on 6/5/2026.
//

import SwiftUI

struct ExpiringView: View {
    let expiringItems = [
        ("Milk", "Today", "Use it now"),
        ("Eggs", "Tomorrow", "Use soon"),
        ("Bread", "In 2 days", "Still okay"),
        ("Yogurt", "In 3 days", "Plan a meal"),
        ("Chicken", "In 4 days", "Use this week")
    ]

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

            VStack(alignment: .leading, spacing: 20) {
                Text("Expiring Soon")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("Items that need your attention")
                    .foregroundColor(.white.opacity(0.7))

                ForEach(expiringItems, id: \.0) { item in
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(item.0)
                                .font(.headline)
                                .foregroundColor(.white)

                            Text(item.2)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                        }

                        Spacer()

                        Text(item.1)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.white.opacity(0.18))
                            .clipShape(Capsule())
                    }
                    .padding()
                    .background(Color.white.opacity(0.12))
                    .cornerRadius(18)
                }

                Spacer()
            }
            .padding(20)
        }
    }
}

#Preview {
    ExpiringView()
}

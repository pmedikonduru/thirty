//
//  HabitChallengeCardView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/4/24.
//

import SwiftUI

struct HabitChallengeCardView: View {
    var title: String
    var description: String

    var body: some View {
        VStack() {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 5)
                .foregroundStyle(Color.white)
            VStack(alignment: .leading) {
                Text(description)
                    .font(.body)
                    .foregroundStyle(.lightGrey)
                    .padding(.bottom, 10)
                NavigationLink(destination: HabitMoreView()) {
                    Text("learn more...")
                        .font(.body)
                        .foregroundColor(Color.cyan) // Link color
                        .underline() // Optional: underline to indicate link
                }
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                    .padding(.horizontal, 10)
            )
        }
}



#Preview {
    HabitChallengeCardView(title: "Habit Challenge", description: "This month's challenge is to meditate every day for 10 minutes. Meditation helps improve focus and reduces stress.")
}

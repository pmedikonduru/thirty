//
//  SuccessStreakView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/4/24.
//

import SwiftUI

struct SuccessStreakView: View {
    @ObservedObject var dataManager: DataManager

    var body: some View {
        VStack {
            Text("take charge of your life.")
                .font(.headline)
                .foregroundStyle(.lightGrey)

            Text("one day at a time")
                .font(.caption)
                .foregroundStyle(.lightGrey)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 10) {
                ForEach(1...30, id: \.self) { day in
                    ZStack {
                        Rectangle()
                            .fill(day <= dataManager.streak ? Color.green : Color.lightGrey)
                            .frame(width: 30, height: 30)
                            .cornerRadius(5)
                        if day <= dataManager.streak {
                            Text("\(day)")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                }
            }

            HStack {
                Text("\(dataManager.streak) day streak 🔥")
                    .font(.caption)
                    .foregroundStyle(.lightGrey)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .padding(.horizontal)
        )
    }
}

//
//  HomeView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/3/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var dataManager = DataManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.gray, Color.deepBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        HStack {
                            Text("Thirty")
                                .font(.headline)
                                .foregroundStyle(.lightGrey)
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "heart")
                                    .foregroundStyle(.lightGrey)
                            }
                            .buttonStyle(PlainButtonStyle())
                            Button(action: {}) {
                                Image(systemName: "gear")
                                    .foregroundStyle(.lightGrey)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                        
                        HabitChallengeCardView(
                            title: "Habit challenge",
                            description: "benefits of habit blabh ablah balh ablha hlashdjfhaskdhflsakdjfhsadkjfhsladkfhaslkfhkdsafhsa"
                        )
                        .padding(.bottom, 20)
                        
                        SuccessStreakView(streak: dataManager.streak)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

//
//  HomeView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/3/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.deepBlue, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                GeometryReader { geometry in
                    VStack {
                        ScrollView {
                            VStack {
                                HabitChallengeCardView(
                                    title: "Habit challenge",
                                    description: "benefits of habit blabh ablah balh ablha hlashdjfhaskdhflsakdjfhsadkjfhsladkfhaslkfhkdsafhsa"
                                )
                                .padding(.bottom, 20)
                                
                                SuccessStreakView(dataManager: dataManager) // Pass the dataManager here
                            }
                            .padding(.top, 50)
                        }
                        .frame(height: geometry.size.height - 100) // Adjust the height to fit above the TabView
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(dataManager: DataManager()) // Pass an instance of DataManager
}

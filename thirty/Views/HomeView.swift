//
//  HomeView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/3/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var dataManager: DataManager
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.deepBlue, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                GeometryReader { geometry in
                    VStack {
                        ScrollView {
                            VStack {
                                Text("Hello, \(viewModel.name).")
                                    .foregroundStyle(.white)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                
                                
                                HabitChallengeCardView(
                                    title: "Habit challenge",
                                    description: "benefits of habit blabh ablah balh ablha hlashdjfhaskdhflsakdjfhsadkjfhsladkfhaslkfhkdsafhsa"
                                )
                                .padding(.bottom, 20)
                                
                                SuccessStreakView(dataManager: dataManager)
                            }
                            .padding(.top, 50)
                        }
                        .frame(height: geometry.size.height - 100)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(dataManager: DataManager())
}

//
//  ContentView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/3/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        TabView {
            HomeView(dataManager: dataManager)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            JournalView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Journal")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .accentColor(.lightGrey)
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = UIColor(.lightGrey)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataManager())
}



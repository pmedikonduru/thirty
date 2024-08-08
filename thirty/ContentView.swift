//
//  ContentView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/3/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataManager: DataManager

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black // Set the desired tab bar color

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
    }

    var body: some View {
        TabView {
            HomeView(dataManager: dataManager)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .background(Color.blue.edgesIgnoringSafeArea(.all)) // HomeView background color

            JournalView(dataManager: dataManager)
                .tabItem {
                    Image(systemName: "book")
                    Text("Journal")
                }
                .background(Color.black.edgesIgnoringSafeArea(.all)) // JournalView background color

            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .background(Color.gray.edgesIgnoringSafeArea(.all)) // ProfileView background color
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataManager())
}

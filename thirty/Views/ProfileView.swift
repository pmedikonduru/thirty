//
//  ProfileView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/3/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var dataManager = DataManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.gray, Color.deepBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
            }
        }
    }
}


#Preview {
    ProfileView()
}

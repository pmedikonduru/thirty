//
//  thirtyApp.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/3/24.
//

import SwiftUI

@main
struct thirtyApp: App {
    @StateObject private var dataManager = DataManager()
       
       var body: some Scene {
           WindowGroup {
               ContentView()
                   .environmentObject(dataManager)
           }
       }
}

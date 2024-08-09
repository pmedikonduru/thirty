//
//  ProfileView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/3/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            NavigationView {
                VStack {
                    List {
                        // Profile Section
                        Section(header: Text("PROFILE")
                            .foregroundColor(.white)) {
                                Picker(selection: $viewModel.selectedGoal, label: Text("Goal").foregroundColor(.white)) {
                                    ForEach(viewModel.goals, id: \.self) { goal in
                                        Text(goal).tag(goal)
                                    }
                                }
                                .listRowBackground(Color.gray.opacity(0.2))
                                .foregroundStyle(.white)
                                
                                NavigationLink(destination: Text("Accountability Partners")) {
                                    HStack {
                                        Text("Accountability Partners")
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("Set up")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .listRowBackground(Color.gray.opacity(0.2))
                        }

                        // Account Section
                        Section(header: Text("ACCOUNT")
                            .foregroundColor(.white)) {
                                HStack {
                                    Text("Display Name")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text(viewModel.displayName)
                                        .foregroundColor(.gray)
                                }
                                .listRowBackground(Color.gray.opacity(0.2))
                                
                                HStack {
                                    Text("Phone Number")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text(viewModel.phoneNumber)
                                        .foregroundColor(.gray)
                                }
                                .listRowBackground(Color.gray.opacity(0.2))
                        }

                        // Notifications Section
                        Section(header: Text("NOTIFICATIONS")
                            .foregroundColor(.white)) {
                                Toggle(isOn: .constant(true)) {
                                    Text("Receive Push Notifications")
                                        .foregroundColor(.white)
                                }
                                .listRowBackground(Color.gray.opacity(0.2))

                                Toggle(isOn: .constant(true)) {
                                    Text("Receive Email Updates")
                                        .foregroundColor(.white)
                                }
                                .listRowBackground(Color.gray.opacity(0.2))
                        }

                        // Subscription Section
                        Section(header: Text("SUBSCRIPTION")
                            .foregroundColor(.white)) {
                                NavigationLink(destination: Text("Manage Subscription")) {
                                    HStack {
                                        Text("Manage Subscription")
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("Active")
                                            .foregroundColor(.green)
                                    }
                                }
                                .listRowBackground(Color.gray.opacity(0.2))
                        }

                        // Danger Zone Section
                        Section(header: Text("DANGER ZONE")
                            .foregroundColor(.white)) {

                            Button(action: {
                                viewModel.signOut()
                            }) {
                                HStack {
                                    Text("Sign Out")
                                        .foregroundColor(.white)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.2))

                            Button(action: {
                                viewModel.deleteAccount { result in
                                    switch result {
                                    case .success:
                                        // Handle successful account deletion
                                        print("Account deleted successfully")
                                    case .failure(let error):
                                        // Handle error
                                        print("Failed to delete account: \(error.localizedDescription)")
                                    }
                                }
                            }) {
                                HStack {
                                    Text("Delete Account")
                                        .foregroundColor(.red)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                        }

                        // Footer Section
                        VStack {
                            HStack {
                                Spacer()
                                Text("terms")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("privacy")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("v.1.0")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .padding()
                        .listRowBackground(Color.black)
                    }
                    .listStyle(GroupedListStyle())
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.white)
                }
                .navigationTitle("Profile")
            }
            .colorScheme(.dark)
        }
    }
}

#Preview {
    ProfileView()
}

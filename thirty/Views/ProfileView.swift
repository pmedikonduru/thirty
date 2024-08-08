//
//  ProfileView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/3/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var selectedGoal = "Be more present"
    let goals = ["Be more present", "Improve fitness", "Learn a new skill", "Read more books"]
    
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
                                Picker(selection: $selectedGoal, label: Text("goal").foregroundColor(.white)) {
                                    ForEach(goals, id: \.self) { goal in
                                        Text(goal).tag(goal)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                            .foregroundStyle(.white)
                            
                            NavigationLink(destination: Text("Accountability Partners")) {
                                HStack {
                                    Text("Accountabilty Partners")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("Set up")
                                        .foregroundColor(.gray)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                        }
                        
                        // Spacer between sections
                        .listRowBackground(Color.black)
                        
                        // Account Section
                        Section(header: Text("ACCOUNT")
                            .foregroundColor(.white)) {
                                NavigationLink(destination: Text("Premium")) {
                                    HStack {
                                        Text("Subscription")
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("★ Go Premium")
                                            .foregroundStyle(.blue)
                                            .background(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .fill(.blue)
                                                    .opacity(0.3) // Adjust opacity as needed
                                            )
                                    }
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                            
                            
                            HStack {
                                Text("Display Name")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("Pranav")
                                    .foregroundColor(.gray)
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                            
                            HStack {
                                Text("Phone Number")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("737-318-1779")
                                    .foregroundColor(.gray)
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                        }
                        
                        // Spacer between sections
                        .listRowBackground(Color.black)
                        
                        // Help Section
                        Section(header: Text("HELP")
                            .foregroundColor(.white)) {
                            NavigationLink(destination: Text("Call a Founder")) {
                                HStack {
                                    Text("Call a Founder")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                            
                            NavigationLink(destination: Text("FAQs")) {
                                HStack {
                                    Text("FAQs")
                                        .foregroundColor(.white)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                            
                            NavigationLink(destination: Text("Feedback Form")) {
                                HStack {
                                    Text("Leave Us Feedback To Help Improve Thirty!")
                                        .foregroundColor(.white)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                        }
                        
                        // Spacer between sections
                        .listRowBackground(Color.black)
                        
                        // More Section
                        Section(header: Text("SOCIAL")
                            .foregroundColor(.white)) {

                            NavigationLink(destination: Text("Leave a Review")) {
                                HStack {
                                    Text("Leave a Review")
                                        .foregroundColor(.white)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                            
                            NavigationLink(destination: Text("Refer a Friend")) {
                                HStack {
                                    Text("Refer a Friend")
                                        .foregroundColor(.white)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                        }
                        
                        // Spacer between sections
                        .listRowBackground(Color.black)
                        
                        //Sign out/Delete Account section
                        Section(header: Text("DANGER ZONE")
                            .foregroundColor(.white)) {

                            NavigationLink(destination: Text("Sign Out")) {
                                HStack {
                                    Text("Sign Out")
                                        .foregroundColor(.white)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                            
                            NavigationLink(destination: Text("Delete Account")) {
                                HStack {
                                    Text("Delete Account")
                                        .foregroundColor(.red)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
                        }
                        
                        // Spacer between sections
                        .listRowBackground(Color.black)
                        
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
                    .scrollContentBackground(.hidden) // Prevent content background color issues
                    .foregroundColor(.white) // Ensure all text is white
                }
                .navigationTitle("Profile")
            }
            .colorScheme(.dark) // Force dark mode
        }
    }
}

#Preview {
    ProfileView()
}

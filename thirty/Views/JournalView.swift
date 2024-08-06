//
//  JournalView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/3/24.
//

import SwiftUI

struct JournalView: View {
    @StateObject private var dataManager = DataManager()
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedDate = Date()
    @State private var selectedImage: UIImage? = nil
    @State private var userProfileImage: String = "profile_picture" // Example placeholder
    @State private var userName: String = "John Doe" // Example placeholder
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.gray, Color.deepBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        // Journal post writing form
                        VStack {
                            Text("Write a Journal Post")
                                .font(.headline)
                                .foregroundStyle(.lightGrey)
                            
                            TextField("Title", text: $title)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            TextEditor(text: $content)
                                .frame(height: 100)
                                .border(Color.gray, width: 1)
                            
                            HStack {
                                Text("Date:")
                                Spacer()
                                Text("\(Date())")
                            }
                            Button(action: {
                                dataManager.addJournalPost(title: title, content: content, date: selectedDate, image: selectedImage, userProfileImage: userProfileImage, userName: userName)
                                dataManager.streak += 1
                                title = ""
                                content = ""
                            }) {
                                Text("Upload")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        
                        // Display Journal Posts
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                            ForEach(dataManager.journalPosts) { post in
                                NavigationLink(destination: JournalPostView(
                                    title: post.title,
                                    slides: post.slides,
                                    userProfileImage: post.userProfileImage,
                                    userName: post.userName,
                                    postDate: "\(post.date)"
                                )) {
                                    VStack(alignment: .leading) {
                                        Text(post.title)
                                            .font(.headline)
                                        Text("\(post.date)")
                                            .font(.caption)
                                        Text(post.content)
                                            .font(.body)
                                            .lineLimit(3)
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    JournalView()
}

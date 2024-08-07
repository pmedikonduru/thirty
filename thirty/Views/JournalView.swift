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
    @State private var selectedImage: UIImage? = nil
    @State private var userProfileImage: String = "profile_picture" // Example placeholder
    @State private var userName: String = "John Doe" // Example placeholder

    @State private var lastPostedDate = Date.distantPast // Initialize to a very old date
    @State private var showAlert = false
    @State private var alertContent: Alert?

    func presentAlert(alert: Alert) {
        alertContent = alert
        showAlert = true
    }

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
                                .foregroundStyle(.white)
                                .fontWeight(.bold)

                            TextField("Title", text: $title)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            TextEditor(text: $content)
                                .frame(height: 100)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                            HStack {
                                Text("Date:")
                                Spacer()
                                Text(Date(), style: .date)
                            }
                            .foregroundStyle(.white)
                            .fontWeight(.bold)

                            Button(action: {
                                if lastPostedDate < Calendar.current.startOfDay(for: Date()) {
                                    // No post today, allow adding a new one
                                    dataManager.addOrUpdateJournalPost(title: title, content: content, date: Date(), image: selectedImage, userProfileImage: userProfileImage, userName: userName)
                                    lastPostedDate = Date()
                                    title = ""
                                    content = ""
                                } else {
                                    // Existing post today, prompt user about multiple uploads
                                    let alert = Alert(
                                        title: Text("Multiple Uploads Today"),
                                        message: Text("You've already uploaded posts today. Uploading again will replace the existing one. Are you sure you want to continue?"),
                                        primaryButton: .destructive(Text("Continue")) {
                                            // Add or update the post (same logic as before)
                                            dataManager.addOrUpdateJournalPost(title: title, content: content, date: Date(), image: selectedImage, userProfileImage: userProfileImage, userName: userName)
                                            lastPostedDate = Date()
                                            title = ""
                                            content = ""
                                        },
                                        secondaryButton: .cancel()
                                    )
                                    presentAlert(alert: alert)
                                }
                            }) {
                                Text("Upload")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
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
                                    postDate: post.date.formatted(.dateTime.day().month(.wide).year())
                                )) {
                                    VStack(alignment: .leading) {
                                        Text(post.title)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(post.date.formatted(.dateTime.day().month(.wide).year()))
                                            .font(.caption)
                                            .foregroundColor(.white)
                                        Text(String(post.content.prefix(10))) // Show only the first 10 characters
                                            .font(.body)
                                            .foregroundColor(.white)
                                            .lineLimit(2)
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.horizontal, 20)

                        Spacer()

                        SuccessStreakView(dataManager: dataManager)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                alertContent ?? Alert(title: Text("Error"), message: Text("Unknown error"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    JournalView()
}

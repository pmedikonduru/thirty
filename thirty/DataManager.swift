//
//  DataManager.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/4/24.
//

import SwiftUI
import Combine

class DataManager: ObservableObject {
    @Published var journalPosts: [JournalPost] = []
    @Published var streak: Int = 0
    
    private var lastPostDate: Date?
    
    func addOrUpdateJournalPost(title: String, content: String, date: Date, image: UIImage?, userProfileImage: String, userName: String, isReplacement: Bool) {
        let newPost = JournalPost(title: title, content: content, date: date, image: image, userProfileImage: userProfileImage, userName: userName)
        
        if let index = journalPosts.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            // Update existing post
            journalPosts[index] = newPost
        } else {
            // Add new post
            journalPosts.append(newPost)
            if !isReplacement {
                updateStreak(for: date)
            }
        }
    }
    
    private func updateStreak(for date: Date) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: date)
        
        if let lastDate = lastPostDate {
            let components = calendar.dateComponents([.day], from: lastDate, to: today)
            
            if let dayDifference = components.day, dayDifference <= 1 {
                streak += 1
            } else {
                streak = 1 // Reset streak if more than one day has passed
            }
        } else {
            streak = 1 // Initialize streak for the first post
        }
        
        lastPostDate = today
    }
    
    func deleteJournalPost(post: JournalPost) {
        if let index = journalPosts.firstIndex(where: { $0.id == post.id }) {
            journalPosts.remove(at: index)
            // You might need to recalculate streak after deleting a post
            recalculateStreak()
        } else {
            // Handle the case where the post is not found
            print("Post not found in journalPosts")
        }
    }
    
    private func recalculateStreak() {
        let calendar = Calendar.current
        guard lastPostDate != nil else {
            streak = 0
            return
        }
        
        var currentStreak = 0
        var currentDate = calendar.startOfDay(for: Date())
        
        while journalPosts.first(where: { calendar.isDate($0.date, inSameDayAs: currentDate) }) != nil {
            currentStreak += 1
            currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
        }
        
        streak = currentStreak
    }
    
    func getTodaysJournalPost() -> JournalPost? {
        guard !journalPosts.isEmpty else { return nil } // Check if there are any posts

        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date()) // Get the start of today

        return journalPosts.first(where: { calendar.isDate($0.date, inSameDayAs: today) })
    }
}

struct Slide: Identifiable {
    let id = UUID() // Generate a unique identifier for each slide
    var text: String?
    var imageName: String?
}

struct JournalPost: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let date: Date
    let image: UIImage?
    let userProfileImage: String
    let userName: String
    var slides: [Slide] {
        if image != nil {
            return [Slide(text: content, imageName: nil), Slide(text: nil, imageName: "imageNamePlaceholder")] // Replace with actual image handling
        } else {
            return [Slide(text: content, imageName: nil)]
        }
    }
}

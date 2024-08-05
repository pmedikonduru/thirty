//
//  DataManager.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/4/24.
//

import SwiftUI
import Combine
import UIKit

class DataManager: ObservableObject {
    @Published var journalPosts: [JournalPost] = []
    @Published var streak: Int = 0
    
    private var lastPostDate: Date?
    
    func addJournalPost(title: String, content: String, date: Date, image: UIImage?, userProfileImage: String, userName: String) {
        let newPost = JournalPost(title: title, content: content, date: date, image: image, userProfileImage: userProfileImage, userName: userName)
        journalPosts.append(newPost)
        
        if let lastDate = lastPostDate {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: lastDate, to: date)
            
            if let dayDifference = components.day, dayDifference <= 1 {
                streak += 1
            } else {
                streak = 1 // Reset streak if more than one day has passed
            }
        } else {
            streak = 1 // Initialize streak for the first post
        }
        
        lastPostDate = date
    }
    
    func deletePost(at index: Int) {
        journalPosts.remove(at: index)
        // You might need to recalculate streak after deleting a post, depending on your logic
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

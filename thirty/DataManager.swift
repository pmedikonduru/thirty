//
//  DataManager.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/4/24.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class DataManager: ObservableObject {
    @Published var streak: Int = 0
    @Published var lastUploadDate: Date? = nil
    @Published var videos: [Int: URL] = [:] // Store video URLs keyed by day of the month
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    private let userID = Auth.auth().currentUser?.uid ?? "unknown_user"

    init() {
        fetchUserData()
    }

    // Fetch user data from Firestore
    func fetchUserData() {
        db.collection("users").document(userID).getDocument { [weak self] document, error in
            guard let self = self, let document = document, document.exists else {
                print("User data does not exist: \(error?.localizedDescription ?? "No error")")
                return
            }

            let data = document.data()
            self.streak = data?["streak"] as? Int ?? 0
            if let timestamp = data?["lastUploadDate"] as? Timestamp {
                self.lastUploadDate = timestamp.dateValue()
            }
            self.fetchVideos()
        }
    }

    // Fetch videos from Firestore
    func fetchVideos() {
        db.collection("users").document(userID).collection("journal_videos").getDocuments { [weak self] snapshot, error in
            guard let self = self, let documents = snapshot?.documents else {
                print("Error fetching videos: \(error?.localizedDescription ?? "No error")")
                return
            }

            for document in documents {
                let data = document.data()
                if let urlString = data["videoURL"] as? String, let url = URL(string: urlString) {
                    if let timestamp = data["timestamp"] as? Timestamp {
                        let calendar = Calendar.current
                        let day = calendar.component(.day, from: timestamp.dateValue())
                        self.videos[day] = url
                    }
                }
            }
        }
    }

    // Check if a video exists for a specific day
    func checkForExistingVideo(for day: Int) -> Bool {
        return videos[day] != nil
    }

    // Save journal post (video)
    func saveJournalPost(videoURL: URL, for day: Int, completion: @escaping (Bool) -> Void) {
        if checkForExistingVideo(for: day) {
            promptForReplacement { replace in
                if replace {
                    self.uploadVideo(videoURL, for: day, completion: completion)
                } else {
                    completion(false)
                }
            }
        } else {
            uploadVideo(videoURL, for: day, completion: completion)
        }
    }

    // Prompt the user for replacing an existing video
    private func promptForReplacement(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Replace Video", message: "A video already exists for today. Do you want to replace it?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Replace", style: .destructive, handler: { _ in
                completion(true)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                completion(false)
            }))

            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                scene.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }

    // Upload video to Firebase Storage
    private func uploadVideo(_ videoURL: URL, for day: Int, completion: @escaping (Bool) -> Void) {
      let storageRef = storage.reference().child("journal/\(userID)/day\(day).mov")

      storageRef.putFile(from: videoURL, metadata: nil) { [weak self] metadata, error in
        guard let self = self else { return }
        if let error = error {
          print("Error uploading video: \(error.localizedDescription)")
          completion(false)
          return
        }

        storageRef.downloadURL { url, error in
          guard let downloadURL = url else {
            print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
            completion(false)
            return
          }

          self.saveVideoToFirestore(downloadURL: downloadURL, for: day, completion: completion)
        }
      }
    }

    // Save video download URL to Firestore
    private func saveVideoToFirestore(downloadURL: URL, for day: Int, completion: @escaping (Bool) -> Void) {
        let videoData: [String: Any] = [
            "videoURL": downloadURL.absoluteString,
            "timestamp": Timestamp(date: Date())
        ]

        db.collection("users").document(userID).collection("journal_videos").document("day\(day)").setData(videoData) { error in
            if let error = error {
                print("Error saving journal video: \(error.localizedDescription)")
                completion(false)
            } else {
                self.updateStreak(for: day)
                self.videos[day] = downloadURL
                completion(true)
            }
        }
    }

    // Update user's streak in Firestore
    private func updateStreak(for day: Int) {
        let calendar = Calendar.current
        let today = Date()

        if let lastDate = lastUploadDate {
            let daysBetween = calendar.dateComponents([.day], from: lastDate, to: today).day ?? 0
            if daysBetween == 1 {
                streak += 1
            } else if daysBetween > 1 {
                streak = 1
            }
        } else {
            streak = 1
        }

        lastUploadDate = today

        db.collection("users").document(userID).setData(["streak": streak, "lastUploadDate": Timestamp(date: today)], merge: true)
    }

    // Get the video URL for a specific day
    func getVideoURL(for day: Int) -> URL? {
        return videos[day]
    }
}

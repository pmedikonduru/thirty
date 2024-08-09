//
//  ProfileViewModel.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/9/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var displayName: String = ""
    @Published var phoneNumber: String = ""
    @Published var selectedGoal: String = "Be more present"
    let goals = ["Be more present", "Improve fitness", "Learn a new skill", "Read more books"]
    
    private var auth = Auth.auth()
    private var db = Firestore.firestore()

    init() {
        loadUserData()
    }

    // Load user data from Firebase Auth
    func loadUserData() {
        if let user = auth.currentUser {
            self.displayName = user.displayName ?? "Unknown"
            self.phoneNumber = user.phoneNumber ?? "No Phone"
            // Fetch additional data from Firestore if necessary
            fetchUserDetails(userId: user.uid)
        }
    }

    // Fetch additional user details from Firestore
    private func fetchUserDetails(userId: String) {
        db.collection("users").document(userId).getDocument { [weak self] document, error in
            if let document = document, document.exists {
                if let data = document.data() {
                    self?.displayName = data["name"] as? String ?? "Unknown"
                    self?.phoneNumber = data["phone"] as? String ?? "No Phone"
                }
            } else {
                print("Document does not exist or error: \(String(describing: error))")
            }
        }
    }

    // Sign out user
    func signOut() {
        do {
            try auth.signOut()
            // Handle navigation or any other post sign-out actions here
            print("User signed out successfully")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    // Delete user account
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        let user = auth.currentUser
        user?.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

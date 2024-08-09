//
//  HomeViewModel.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/9/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class HomeViewModel: ObservableObject {
    @Published var name: String = ""
    private let db = Firestore.firestore()
    
    init() {
        fetchUserName()
    }
    
    private func fetchUserName() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let userRef = db.collection("users").document(userId)
        userRef.getDocument { [weak self] document, error in
            if let document = document, document.exists, let data = document.data() {
                if let fullName = data["name"] as? String {
                    self?.name = self?.getFirstName(from: fullName) ?? ""
                }
            } else {
                print("User document does not exist or failed to fetch data")
            }
        }
    }
    
    private func getFirstName(from fullName: String) -> String {
        let nameComponents = fullName.split(separator: " ")
        return nameComponents.first.map(String.init) ?? ""
    }
}

//
//  LoginViewModel.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/8/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMessage = "Fill in all fields."
            
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            
            errorMessage = "Please enter a valid email."
            
            return false
        }
        
        return true
    }
}

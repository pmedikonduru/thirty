//
//  LoginView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/8/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.deepBlue, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // Logo
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.white)
                    
                    Text("Thirty")
                        .font(.title)
                        .foregroundStyle(.white)
                        .bold()
                    
                    
                    // Form Elements
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundStyle(.red)
                    }
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.clear)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.clear)
                    
                    Button {
                        viewModel.login()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.blue)
                                .frame(height: 50)
                            
                            Text("Log In")
                                .foregroundStyle(.white)
                                .bold()
                        }
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 15)
                    
                    NavigationLink("Create An Account", destination: RegistrationView())
                        .padding(.top, 15)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Center horizontally and vertically
            }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    LoginView()
}

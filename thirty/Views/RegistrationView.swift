//
//  RegistrationView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/8/24.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.clear)
                
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.clear)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.clear)
                
                Button {
                    viewModel.register()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.blue)
                            .frame(height: 50)
                        
                        Text("Register")
                            .foregroundStyle(.white)
                            .bold()
                    }
                }
                .padding(.top, 5)
                .padding(.bottom, 15)
                
                Spacer()
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Center horizontally and vertically
        }
    }
}

#Preview {
    RegistrationView()
}

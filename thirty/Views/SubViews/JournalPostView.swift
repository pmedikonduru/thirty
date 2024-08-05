//
//  JournalPostView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/4/24.
//

import SwiftUI

struct JournalPostView: View {
    var title: String
    var slides: [Slide]
    var userProfileImage: String // Placeholder for user profile image
    var userName: String // Placeholder for user name
    var postDate: String // Placeholder for post date
    @State public var liked: Bool = false
    @State public var share: Bool = false
    @State public var saved: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(userProfileImage)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
                
                Text(userName)
                    .font(.headline)
                Spacer()
                Text(postDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
            }
            .padding(.bottom, 5)
            
            Divider()
            
            TabView {
                ForEach(slides) { slide in
                    if let imageName = slide.imageName {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    } else if let text = slide.text {
                        Text(text)
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 300)
            
            Divider()
            
            VStack {
                HStack {
                    Button(action: {
                        liked.toggle()
                    }) {
                        Image(systemName: liked ? "heart.fill" : "heart")
                    }
                    .foregroundStyle(liked ? .red : .primary)
                    
                    Spacer()
                    
                    Button(action: {
                        share.toggle()
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        saved.toggle()
                    }) {
                        Image(systemName: saved ? "bookmark.fill" : "bookmark")
                            .foregroundColor(.black)
                    }
                }
                .padding(.top, 10)
                
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct JournalPostView_Previews: PreviewProvider {
    static var previews: some View {
        JournalPostView(
            title: "Sample Title",
            slides: [
                Slide(text: "Sample Text", imageName: nil),
                Slide(text: nil, imageName: "sample_image")
            ],
            userProfileImage: "profile_picture", // Update with your image name
            userName: "John Doe",
            postDate: "August 4, 2024"
        )
    }
}

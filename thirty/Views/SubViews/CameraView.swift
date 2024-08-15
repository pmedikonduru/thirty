//
//  CameraView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/12/24.
//

import SwiftUI

struct CameraView: View {
    
    @Binding var image: CGImage?
    
    var body: some View {
        GeometryReader { geometry in
            if let image = image {
                Image(decorative: image, scale: 1)
                Image(decorative: image, scale: 1)
                    .resizable()
                    .scaledToFill()
                    .rotationEffect(.degrees(90)) // Rotate 90 degrees counterclockwise
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)

            } else {
                ContentUnavailableView("No camera feed", systemImage: "xmark.circle.fill")
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
            }
        }
    }
    
}
    

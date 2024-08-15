//
//  JournalView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/3/24.
//

import SwiftUI

struct JournalView: View {
    @State private var viewModel = JournalViewModel()
    
    var body: some View {
        ZStack {
            // Full-screen camera preview
            CameraView(image: $viewModel.currentFrame)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    // Camera switch button
                    Button(action: {
                        viewModel.switchCamera()
                    }) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    // Recording timer
                    if viewModel.isRecording {
                        Text(viewModel.recordingDurationString)
                            .font(.headline)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                    }
                }
                
                Spacer()
                
                // Recording button positioned at the bottom center
                Button(action: {
                    viewModel.toggleRecording(for: getCurrentDay())
                }) {
                    Circle()
                        .fill(viewModel.isRecording ? Color.red : Color.white)
                        .frame(width: 70, height: 70)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 5)
                                .frame(width: 90, height: 90)
                        )
                }
                .padding(.bottom, 50)
            }
        }
    }

    private func getCurrentDay() -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: Date())
    }
}

#Preview {
    JournalView()
}

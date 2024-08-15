//
//  SuccessStreakView.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/4/24.
//

import SwiftUI
import AVKit

struct SuccessStreakView: View {
    @ObservedObject var dataManager: DataManager

    var body: some View {
        VStack {
            Text("take charge of your life.")
                .font(.headline)
                .foregroundStyle(.lightGrey)

            Text("one day at a time")
                .font(.caption)
                .foregroundStyle(.lightGrey)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 10) {
                ForEach(1...30, id: \.self) { day in
                    ZStack {
                        Rectangle()
                            .fill(dataManager.videos[day] != nil ? Color.green : Color.lightGrey)
                            .frame(width: 30, height: 30)
                            .cornerRadius(5)

                        if dataManager.videos[day] != nil {
                            Text("\(day)")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    .onTapGesture {
                        if let videoURL = dataManager.getVideoURL(for: day) {
                            playVideo(url: videoURL)
                        }
                    }
                }
            }

            HStack {
                Text("\(dataManager.streak) day streak 🔥")
                    .font(.caption)
                    .foregroundStyle(.lightGrey)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .padding(.horizontal)
        )
        .onAppear {
            dataManager.fetchUserData()
        }
    }

    private func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        let playerController = AVPlayerViewController()
        playerController.player = player

        let windowScene = UIApplication.shared.connectedScenes
            .filter { $0.isKind(of: UIWindowScene.self) }
            .first as? UIWindowScene

        guard let scene = windowScene else { return }
        scene.windows.first?.rootViewController?.present(playerController, animated: true) {
            player.play()
        }
    }
}

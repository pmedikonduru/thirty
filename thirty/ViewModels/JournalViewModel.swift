//
//  JournalViewModel.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/9/24.
//

import Foundation
import CoreImage
import Observation

@Observable
class JournalViewModel {
    var currentFrame: CGImage?
    private let cameraManager = CameraManager()
    private let dataManager = DataManager()
    
    var isRecording = false
    private var recordingStartTime: Date?
    private var timer: Timer?
    
    var recordingDurationString: String {
        guard let startTime = recordingStartTime else { return "00:00" }
        let duration = Date().timeIntervalSince(startTime)
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    init() {
        Task {
            await handleCameraPreviews()
        }
    }
    
    func handleCameraPreviews() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                currentFrame = image
            }
        }
    }
    
    @MainActor
    func toggleRecording(for day: Int) {
        if isRecording {
            stopRecording(for: day) { success in
                self.isRecording = !success
            }
        } else {
            if dataManager.checkForExistingVideo(for: day) {
                dataManager.saveJournalPost(videoURL: cameraManager.getLastRecordedVideoURL()!, for: day) { success in
                    if success {
                        self.cameraManager.startRecording()
                        self.isRecording = true
                        self.recordingStartTime = Date()
                        self.startTimer()
                    }
                }
            } else {
                cameraManager.startRecording()
                isRecording = true
                recordingStartTime = Date()
                startTimer()
            }
        }
    }
    
    @MainActor
    private func stopRecording(for day: Int, completion: @escaping (Bool) -> Void) {
        cameraManager.stopRecording()
        isRecording = false
        stopTimer()
        if let videoURL = cameraManager.getLastRecordedVideoURL() {
            dataManager.saveJournalPost(videoURL: videoURL, for: day) { success in
                completion(success)
                if success {
                    print("Video saved successfully")
                } else {
                    print("Failed to save video")
                }
            }
        } else {
            completion(false)
        }
    }
    
    @MainActor
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            // State changes will trigger UI updates
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func switchCamera() {
        cameraManager.switchCamera()
    }
}


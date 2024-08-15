//
//  CameraManager.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/11/24.
//

import Foundation
import AVFoundation

class CameraManager: NSObject {
    
    private let captureSession = AVCaptureSession()
    
    private var deviceInput: AVCaptureDeviceInput?
    
    private var videoOutput: AVCaptureVideoDataOutput?
    
    private var movieOutput = AVCaptureMovieFileOutput()
    
    private var currentCameraPosition: AVCaptureDevice.Position = .back
    
    private var sessionQueue = DispatchQueue(label: "video.preview.session")
    
    private var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            var isAuthorized = status == .authorized
            
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }
    
    private var addToPreviewStream: ((CGImage) -> Void)?
    private var lastRecordedVideoURL: URL?
    
    lazy var previewStream: AsyncStream<CGImage> = {
        AsyncStream { continuation in
            addToPreviewStream = { cgImage in
                continuation.yield(cgImage)
            }
        }
    }()
    
    override init() {
        super.init()
        
        Task {
            await configureSession()
            await startSession()
        }
    }
    
    private func configureSession() async {
        guard await isAuthorized else { return }
        
        captureSession.beginConfiguration()
        
        defer {
            self.captureSession.commitConfiguration()
        }
        
        try? addCameraInput(for: currentCameraPosition)
        
        videoOutput = AVCaptureVideoDataOutput()
        videoOutput?.setSampleBufferDelegate(self, queue: sessionQueue)
        
        guard let videoOutput = videoOutput,
              captureSession.canAddOutput(videoOutput),
              captureSession.canAddOutput(movieOutput) else {
            print("Unable to add outputs to capture session.")
            return
        }
        
        captureSession.addOutput(videoOutput)
        captureSession.addOutput(movieOutput)
    }
    
    private func addCameraInput(for position: AVCaptureDevice.Position) throws {
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) else {
            print("Unable to find camera for position \(position).")
            return
        }
        
        let input = try AVCaptureDeviceInput(device: camera)
        
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
            
            deviceInput = input
            currentCameraPosition = position
            
            // Accessing the zoom factor range correctly
            let minZoomFactor = camera.minAvailableVideoZoomFactor
            let maxZoomFactor = camera.maxAvailableVideoZoomFactor
            let targetZoomFactor = minZoomFactor  // Or some other logic to determine the target zoom factor
            
            do {
                try camera.lockForConfiguration()
                camera.videoZoomFactor = targetZoomFactor
                camera.unlockForConfiguration()
            } catch {
                print("Error setting camera zoom factor: \(error)")
            }
        } else {
            print("Unable to add camera input to capture session.")
        }
    }

    private func startSession() async {
        guard await isAuthorized else { return }
        captureSession.startRunning()
    }
    
    func startRecording() {
        let outputFilePath = NSTemporaryDirectory().appending(UUID().uuidString).appending(".mov")
        let outputFileURL = URL(fileURLWithPath: outputFilePath)
        lastRecordedVideoURL = outputFileURL
        movieOutput.startRecording(to: outputFileURL, recordingDelegate: self)
    }
    
    func stopRecording() {
        movieOutput.stopRecording()
    }
    
    func switchCamera() {
        sessionQueue.async {
            self.captureSession.beginConfiguration()
            if let currentInput = self.deviceInput {
                self.captureSession.removeInput(currentInput)
            }
            
            self.currentCameraPosition = (self.currentCameraPosition == .back) ? .front : .back
            
            do {
                try self.addCameraInput(for: self.currentCameraPosition)
            } catch {
                print("Error switching cameras: \(error)")
            }
            
            self.captureSession.commitConfiguration()
        }
    }
    
    func getLastRecordedVideoURL() -> URL? {
        return lastRecordedVideoURL
    }
    
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        guard let currentFrame = sampleBuffer.cgImage else { return }
        addToPreviewStream?(currentFrame)
    }
}

extension CameraManager: AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Error recording movie: \(error.localizedDescription)")
        } else {
            print("Movie recorded successfully to \(outputFileURL.absoluteString)")
        }
    }
}

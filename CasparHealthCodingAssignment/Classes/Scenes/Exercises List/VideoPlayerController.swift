//
//  VideoPlayerController.swift
//  CasparHealth
//
//  Created by Gennadii Berezovskii on 19.09.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit
import AVKit

extension Notification.Name {
    
    // swiftlint:disable:next identifier_name
    static let AVSystemControllerSystemVolumeDidChangeNotification = Notification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification")
    
    static let VideoPlayerControllerPlaybackStartedNotification = Notification.Name(rawValue: "VideoPlayerControllerPlaybackStartedNotification")
    static let VideoPlayerControllerPlaybackPausedNotification = Notification.Name(rawValue: "VideoPlayerControllerPlaybackPausedNotification")
}

class VideoPlayerController: UIViewController {
    
    var videoPlayerViewController: AVPlayerViewController?
    @objc var player: AVPlayer?
    
    private var videoFileName: String?
    private var downloadTask: URLSessionDownloadTask?
    
    private let rateKeyPath = #keyPath(VideoPlayerController.player.rate)
    private let mutedKeyPath = #keyPath(VideoPlayerController.player.isMuted)
    private let statusKeyPath = #keyPath(VideoPlayerController.player.currentItem.status)
    private var observedPlayerKeyPaths: [String] {
        return [rateKeyPath, mutedKeyPath, statusKeyPath]
    }
    private var playbackHasStarted = false
    
    private let activityIndicator: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .whiteLarge))
    
    var audioURL: URL? {
        didSet {
            guard let audioURL = self.audioURL else {
                return
            }
            
            player?.volume = 0
            
            audioPlayer = AVPlayer(url: audioURL)
            addSyncObservers()
        }
    }
    
    private var audioPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.soloAmbient)))
    }
    
    deinit {
        if player != nil {
            observedPlayerKeyPaths.forEach { keyPath in
                removeObserver(self, forKeyPath: keyPath)
            }
        }
        
        if audioPlayer != nil {
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemTimeJumped, object: nil)
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
        }
    }
    
    func setupIn(containerView: UIView, playsFullscreen: Bool = false) {
        let videoPlayerViewController = AVPlayerViewController()
        
        videoPlayerViewController.showsPlaybackControls = false
        
        addChild(videoPlayerViewController)
        videoPlayerViewController.view.frame = view.bounds
        videoPlayerViewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.addSubview(videoPlayerViewController.view)
        videoPlayerViewController.didMove(toParent: self)
        
        videoPlayerViewController.exitsFullScreenWhenPlaybackEnds = playsFullscreen
        videoPlayerViewController.entersFullScreenWhenPlaybackBegins = playsFullscreen
        videoPlayerViewController.showsPlaybackControls = playsFullscreen
        
        self.videoPlayerViewController = videoPlayerViewController
        
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        view.addConstraints(.centerX, .centerY, item: activityIndicator, toItem: view)
    }
    
    func setupStreamingVideoWith(url: URL, completion: @escaping (AVPlayer) -> Void) {
        activityIndicator.stopAnimating()
        
        let player = AVPlayer(url: url)
        self.player = player
        
        observedPlayerKeyPaths.forEach { keyPath in
            addObserver(self, forKeyPath: keyPath, options: [], context: nil)
        }
        
        videoPlayerViewController?.view.backgroundColor = UIColor.separator
        
        completion(player)
        self.videoPlayerViewController?.player = player
    }
    
    private func addSyncObservers() {
        _ = NotificationCenter.default.addObserver(forName: .AVPlayerItemTimeJumped, object: player?.currentItem, queue: nil) { [weak self] _ in
            guard let player = self?.player else { return }
            let currentTime = player.currentTime()
            self?.audioPlayer?.seek(to: currentTime)
            self?.audioPlayer?.rate = player.rate
        }
        
        _ = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: nil) { [weak self] _ in
            self?.audioPlayer?.pause()
            self?.audioPlayer?.seek(to: CMTime.zero)
        }
        
        _ = NotificationCenter.default.addObserver(forName: Notification.Name.AVSystemControllerSystemVolumeDidChangeNotification, object: nil, queue: nil) { _ in
            try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)))
        }
    }
    
    // swiftlint:disable:next block_based_kvo
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let keyPath = keyPath, observedPlayerKeyPaths.contains(keyPath),
            let videoPlayer = player
            else { return }
        
        switch keyPath {
        case rateKeyPath:
            if !playbackHasStarted, videoPlayer.rate > 0 {
                playbackHasStarted = true
                NotificationCenter.default.post(name: .VideoPlayerControllerPlaybackStartedNotification, object: self)
            } else if playbackHasStarted, videoPlayer.rate == 0 {
                playbackHasStarted = false
                if player?.currentTime() != player?.currentItem?.duration {
                    NotificationCenter.default.post(name: .VideoPlayerControllerPlaybackPausedNotification, object: self)
                }
            }
            
            audioPlayer?.rate = videoPlayer.rate
            audioPlayer?.seek(to: videoPlayer.currentTime())
            
        case mutedKeyPath:
            guard let audioPlayer = audioPlayer else {
                break
            }
            audioPlayer.isMuted = videoPlayer.isMuted
            videoPlayer.volume = 0
            
        case statusKeyPath:
            // If video is readyToPlay or failed loading, uncover the player so that user can see the controls or error state
            guard videoPlayer.status != .unknown else {
                break
            }
            UIView.animate(withDuration: 0.15, animations: {
                self.videoPlayerViewController?.contentOverlayView?.backgroundColor = .clear
            })
            
        default: break
        }
    }
    
    func resetToStart() {
        player?.rate = 0
        player?.seek(to: CMTime.zero)
        videoPlayerViewController?.showsPlaybackControls = true
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
private func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}

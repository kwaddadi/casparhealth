//
//  ExerciseDetailViewController.swift
//  CH_PatientApp
//
//  Created by Rui Miguel on 06/03/2017.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import UIKit
import AVKit
import Alamofire
import AlamofireImage

protocol ExerciseDetailViewControllerDelegate: class {
    
    func exerciseDetailViewController(_ controller: ExerciseDetailViewController, didStart exerciseConfig: ExerciseConfiguration)
    func exerciseDetailViewControllerWantsToSkip(_ controller: ExerciseDetailViewController, exerciseConfig: ExerciseConfiguration)
    func exerciseDetailViewControllerWantsToDismiss(_ controller: ExerciseDetailViewController)
    
}

final class ExerciseDetailViewController: UIViewController {
    
    var exerciseBasicInfo: Exercise?
    var exerciseCategoriesCollection: ExerciseCategoriesCollection?
    var exerciseConfiguration: ExerciseConfiguration?
    var exerciseNumber: Int = 1
    var exerciseCount: Int = 1
    
    var isSingleExerciseFlow = false
    
    var customPresentationController: CustomPresentationController?
    
    weak var delegate: ExerciseDetailViewControllerDelegate?
    
    @IBOutlet var viewModel: ExerciseDetailViewModel!
    
    let startDate = Date()
    
    private let videoPlayerViewController = VideoPlayerController()
    
    private var rateKeyPathObservation: NSKeyValueObservation?
    private var videoBoundsKeyPathObservation: NSKeyValueObservation?
    private var statusKeyPathObservation: NSKeyValueObservation?
    
    private let timeFormatter: DateComponentsFormatter = {
        $0.unitsStyle = .full
        $0.allowedUnits = [.hour, .minute, .second]
        $0.maximumUnitCount = 1
        return $0
    }(DateComponentsFormatter())
    
    var thumbnailImageView: UIImageView?
    
    var canStartExercise: Bool {
        guard let exerciseBasicInfo = exerciseBasicInfo else {
            return false
        }
        
        return !exerciseBasicInfo.isCompleted
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideoPlayer()
        setupUI()
        addThumbnail()
        
        title = NSLocalizedString("My Training", comment: "")
        
        viewModel.exerciseTitleLabel?.text = exerciseBasicInfo?.title

        viewModel.exerciseNumberLabel.text = "\(exerciseNumber)/\(exerciseCount)"
    }
    
    deinit {
        rateKeyPathObservation = nil
        videoBoundsKeyPathObservation = nil
        statusKeyPathObservation = nil
    }
    
    func setupUI() {
        guard let configuration = exerciseConfiguration else {
            assertionFailure()
            return
        }
        
        prepareVideoPlayerForPlayback()
        exerciseConfiguration = configuration
        
        if !configuration.noteFromTherapist.isEmpty {
            UIView.animate(withDuration: 0.3) {
                self.viewModel.therapistAdviceView?.alpha = 1
            }
            viewModel.therapistAdviceView?.subtitleLabel?.text = configuration.noteFromTherapist
        }
        
        let audioURL = configuration.localisedAudioURL ?? configuration.audioURLs.availableLanguageURLs.first
        loadVideo(from: configuration.videoURLs.mp4, withAudioFrom: audioURL)
        
        if canStartExercise {
            viewModel.startButton?.isEnabled = true
        }
        setupActionButton()
        
        if let equipmentList = exerciseCategoriesCollection?.equipmentListFor(exerciseConfiguration: configuration) {
            viewModel.equipmentListView?.addTags(equipmentList)
        }
        
        if case .exercise(let exerciseType, let details, _) = configuration.kind {
            viewModel.setsCountView?.setsRepsCount = details.setCount
            
            switch exerciseType {
            case .timeBased:
                viewModel.repsTitleLabel.text = NSLocalizedString("Seconds_Short", comment: "Seconds title text displayed on Exercise Details screen").uppercased()
                viewModel.repsCountView?.setsRepsCount = details.repetitionDuration
            case .repetitionsAndSets:
                viewModel.repsCountView?.setsRepsCount = details.repetitionCount
            }
        }
        
        if isSingleExerciseFlow {
            viewModel.exerciseNumberLabel.isHidden = isSingleExerciseFlow
            viewModel.skipButton.setTitle(NSLocalizedString("Cancel", comment: "Cancel (Skip) button title in single exercise flow").uppercased(), for: .normal)
        }
        
    }
    
    func fadeOutThumbnail() {
        thumbnailImageView?.fadeOut(withDuration: 0.3, completion: {
            self.thumbnailImageView?.removeFromSuperview()
            self.thumbnailImageView = nil
        })
    }
    
    // MARK: Actions
    
    @IBAction func startExerciseButtonPressed(_ sender: Any) {
        delegate?.exerciseDetailViewControllerWantsToDismiss(self)
    }
    
    @IBAction func skipExerciseButtonPressed(_ sender: Any) {
        if isSingleExerciseFlow {
            guard let exerciseConfiguration = exerciseConfiguration else {
                assertionFailure()
                return
            }
            
            delegate?.exerciseDetailViewControllerWantsToSkip(self, exerciseConfig: exerciseConfiguration)
            return
        }
        
        let title = NSLocalizedString("ExerciseSkip_Alert_Title", comment: "Confirmation asked to user after they tap to skip exercise.")
        let message = NSLocalizedString("ExerciseSkip_Alert_Message", comment: "Alert message when user taps to skip exercise")
        
        let confirmButtonTitle = NSLocalizedString("ExerciseSkip_Alert_ConfirmButton", comment: "").uppercased()
        let cancelButtonTitle = NSLocalizedString("ExerciseSkip_Alert_CancelButton", comment: "").uppercased()

        let confirmButtonAction = UIAlertAction(title: confirmButtonTitle, style: .default, handler: { _ in
            guard let exerciseConfiguration = self.exerciseConfiguration else {
                assertionFailure()
                return
            }
            
            self.dismiss(animated: true, completion: nil)
            self.customPresentationController = nil

            self.viewModel.skipButton.setTitle("", for: .normal)
            self.viewModel.skipButton.isLoading = true
            self.viewModel.startButton.isEnabled = false
            self.delegate?.exerciseDetailViewControllerWantsToSkip(self, exerciseConfig: exerciseConfiguration)
        })
        
        let cancelButtonAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        })
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(confirmButtonAction)
        alertController.addAction(cancelButtonAction)
                
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: UI Setup
    
    private func addThumbnail() {
        guard let thumbnailImageURL = exerciseBasicInfo?.thumbnailURL else {
            return
        }
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        thumbnailImageView = imageView
        let contentOverlayView = videoPlayerViewController.videoPlayerViewController?.contentOverlayView
        contentOverlayView?.addSubview(imageView)
        
        imageView.frame = contentOverlayView?.frame ?? .zero
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.af_setImage(withURL: thumbnailImageURL)
    }
    
    func setupVideoPlayer() {
        addChild(videoPlayerViewController)
        viewModel.videoContainerView?.addSubview(videoPlayerViewController.view)
        videoPlayerViewController.view.frame = viewModel.videoContainerView!.bounds
        videoPlayerViewController.didMove(toParent: self)
        
        videoPlayerViewController.setupIn(containerView: viewModel.videoContainerView!)
        
        viewModel.watchButton.addTarget(self, action: #selector(startPlayback), for: .touchUpInside)
    }
    
    @objc func startPlayback() {
        viewModel.watchButton.isHidden = true
        videoPlayerViewController.videoPlayerViewController?.showsPlaybackControls = true
        videoPlayerViewController.player?.play()
    }
    
    func prepareVideoPlayerForPlayback() {
        viewModel.videoActivityIndicator?.stopAnimating() // also hides when stopped
        viewModel.watchButton.isHidden = false
    }
    
    func loadVideo(from videoURL: URL, withAudioFrom audioURL: URL?) {
        videoPlayerViewController.setupStreamingVideoWith(url: videoURL) { [weak self] (player) in
            if let audioURL = audioURL {
                self?.videoPlayerViewController.audioURL = audioURL
            }
            self?.setupObservers(player)
        }
        if audioURL == nil {
            presentErrorAlertWithOk(message: NSLocalizedString("No audio available for your language.", comment: ""), okHandler: nil)
        }
    }
    
    func setupObservers(_ player: AVPlayer) {
        videoBoundsKeyPathObservation = videoPlayerViewController.videoPlayerViewController?.observe(\.videoBounds, options: [.new], changeHandler: { [weak self] (controller, _) in
            let videoSize = controller.videoBounds.size
            
            let videoHasASize = videoSize.width > 0 && videoSize.height > 0
            if videoHasASize,
                let thumbnailImageView = self?.thumbnailImageView,
                abs(thumbnailImageView.bounds.height - videoSize.height) > 1 {
                
                self?.fadeOutThumbnail()
            }
        })
        
        rateKeyPathObservation = player.observe(\.rate, options: [.new], changeHandler: { [weak self] (_, _) in
            guard let rate = self?.videoPlayerViewController.player?.rate else {
                return
            }
            if rate > 0 {
                self?.fadeOutThumbnail()
            }
        })
        
        statusKeyPathObservation = player.observe(\.status, options: [.new]) { [weak self] (_, _) in
            guard let status = self?.videoPlayerViewController.player?.status, status != .unknown else {
                return
            }
            
            UIView.animate(withDuration: 0.15, animations: {
                self?.videoPlayerViewController.videoPlayerViewController?.contentOverlayView?.backgroundColor = .clear
            })
        }
    }
    
    // MARK: Actions
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        delegate?.exerciseDetailViewControllerWantsToDismiss(self)
    }
    
    private func setupActionButton() {
        guard let exerciseConfig = exerciseConfiguration,
            canStartExercise else {
                return
        }
        
        switch exerciseConfig.kind {
        case .resource:
            assertionFailure()
        case .exercise:
            viewModel.startButton?.setTitle(NSLocalizedString("Start", comment: "Perform exercise, button title. Constrained space so it should be just one word.").uppercased(), for: .normal)
        }
    }

}

extension ExerciseDetailViewController: UIToolbarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
}

//
//  SingleExerciseContainerViewController.swift
//  CH_PatientApp
//
//  Created by Gennadii Berezovskii on 26.09.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit

protocol SingleExerciseContainerViewControllerDelegate: class {
    func singleExerciseContainerViewControllerDidClose(_ viewController: SingleExerciseContainerViewController)
}

class SingleExerciseContainerViewController: UIViewController, StatusBarAnimatable {
    
    weak var delegate: SingleExerciseContainerViewControllerDelegate?
    
    var exerciseBasicInfo: Exercise?
    var exerciseCategoriesCollection: ExerciseCategoriesCollection?
    var exerciseConfiguration: ExerciseConfiguration?
    
    var shouldHideStatusBar = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let exerciseBasicInfo = exerciseBasicInfo,
              let exerciseConfiguration = exerciseConfiguration else {
            assertionFailure()
            return
        }
        
        showExerciseDetailsViewControllerWith(exerciseBasicInfo: exerciseBasicInfo, exerciseConfiguration: exerciseConfiguration)
    }
    
    override var prefersStatusBarHidden: Bool {
        if UIDevice.current.type == .iPhoneX {
            return false
        }
        
        return shouldHideStatusBar
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateStatusBarStateTo(hidden: true)
    }

}

extension SingleExerciseContainerViewController {
    
    func showExerciseDetailsViewControllerWith(exerciseBasicInfo: Exercise, exerciseConfiguration: ExerciseConfiguration, shouldRemoveExistingViewController: Bool = false) {
        guard let exerciseDetailViewController = storyboard?
                .instantiateViewController(withIdentifier: String(describing: ExerciseDetailViewController.self)) as? ExerciseDetailViewController else {
            assertionFailure()
            return
        }
        
        exerciseDetailViewController.exerciseBasicInfo = exerciseBasicInfo
        exerciseDetailViewController.exerciseConfiguration = exerciseConfiguration
        exerciseDetailViewController.exerciseCategoriesCollection = exerciseCategoriesCollection
        exerciseDetailViewController.exerciseNumber = 1
        exerciseDetailViewController.exerciseCount = 1
        exerciseDetailViewController.delegate = self
        
        exerciseDetailViewController.isSingleExerciseFlow = true
        
        insertChildViewControllerInContainerView(exerciseDetailViewController, shouldRemoveExistingViewController: shouldRemoveExistingViewController)
    }
    
    func hahdleExerciseSkippedWith(exerciseConfiguration: ExerciseConfiguration) {
        delegate?.singleExerciseContainerViewControllerDidClose(self)
    }
    
}

extension SingleExerciseContainerViewController: ExerciseDetailViewControllerDelegate {
    
    func exerciseDetailViewController(_ controller: ExerciseDetailViewController, didStart exerciseConfiguration: ExerciseConfiguration) {
        delegate?.singleExerciseContainerViewControllerDidClose(self)
    }
    
    func exerciseDetailViewControllerWantsToDismiss(_ controller: ExerciseDetailViewController) {
        delegate?.singleExerciseContainerViewControllerDidClose(self)
    }
    
    func exerciseDetailViewControllerWantsToSkip(_ controller: ExerciseDetailViewController, exerciseConfig: ExerciseConfiguration) {
        delegate?.singleExerciseContainerViewControllerDidClose(self)
    }
    
}

extension UIViewController {
    
    func insertChildViewControllerInContainerView(_ childViewController: UIViewController, containerView: UIView, extendsBelowSafeArea: Bool = false, shouldRemoveExistingViewController: Bool = true) {
        containerView.addSubview(childViewController.view)
        self.setupConstraintsFor(view: childViewController.view, containerView: containerView, extendsBelowSafeArea: extendsBelowSafeArea)
        childViewController.didMove(toParent: self)
        self.addChild(childViewController)
        
        guard self.children.count > 1, let existingChildViewController = self.children.first else {
            return
        }
        
        UIView.transition(from: existingChildViewController.view, to: childViewController.view, duration: 0.3, options: [.transitionCrossDissolve, .showHideTransitionViews]) { (completed) in
            if completed, shouldRemoveExistingViewController {
                existingChildViewController.view.removeFromSuperview()
                existingChildViewController.removeFromParent()
            }
        }
        
    }
    
    func insertChildViewControllerInContainerView(_ childViewController: UIViewController, extendsBelowSafeArea: Bool = false, shouldRemoveExistingViewController: Bool = true) {
        insertChildViewControllerInContainerView(childViewController,
                                                 containerView: self.view,
                                                 extendsBelowSafeArea: extendsBelowSafeArea,
                                                 shouldRemoveExistingViewController: shouldRemoveExistingViewController)
    }
    
    func removeChildViewControllerFromContainerView(_ viewControllerToRemove: UIViewController, completion: (() -> Void)?) {
        guard self.children.count > 1,
              let viewControllerToRemoveIndex = self.children.firstIndex(of: viewControllerToRemove)  else {
            return
        }
        
        let viewControllerBelowTheTargetIndex = self.children.index(before: viewControllerToRemoveIndex)
        let viewControllerBelowTheTarget = self.children[viewControllerBelowTheTargetIndex]
        
        UIView.transition(from: viewControllerToRemove.view, to: viewControllerBelowTheTarget.view, duration: 0.3, options: [.transitionCrossDissolve, .showHideTransitionViews]) { (completed) in
            if completed {
                viewControllerToRemove.view.removeFromSuperview()
                viewControllerToRemove.removeFromParent()
                completion?()
            }
        }
    }
    
    func setupConstraintsFor(view: UIView, containerView: UIView, extendsBelowSafeArea: Bool) {
        if #available(iOS 11, *), !extendsBelowSafeArea {
            view.translatesAutoresizingMaskIntoConstraints = false
            let guide = containerView.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                view.topAnchor.constraint(equalTo: guide.topAnchor),
                view.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
            ])
        } else {
            view.frame = containerView.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
}

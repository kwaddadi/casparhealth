//
//  ExercisesListViewController.swift
//  CasparHealth
//
//  Created by Gennadii Berezovskii on 25.09.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit

class ExercisesListViewController: UICollectionViewController, StatusBarAnimatable {
    
    var viewModels = [ExerciseCollectionViewModel]()
    
    var customPresentationController: CustomPresentationController?
    let refreshControl = UIRefreshControl()
    
    var shouldHideStatusBar = false
    
    var viewDidAppearDate: Date?
    var screenId: String {
        return "exercises_list"
    }
    
    lazy var operationQueue = OperationQueue(maxConcurrentOperationCount: 1)
    
    override var prefersStatusBarHidden: Bool {
        if UIDevice.current.type == .iPhoneX {
            return false
        }
        
        return shouldHideStatusBar
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: String(describing: ExerciseCollectionViewCell.self), bundle: Bundle.main)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: ExerciseCollectionViewCell.self))
        
        navigationItem.title = NSLocalizedString("ExercisesControl_Title", comment: "")
        
        setupExercises()
        
        refreshControl.addTarget(self, action: #selector(self.refreshControlTriggered(sender:)), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchTrainingWeek()
    }
    
    @objc func refreshControlTriggered(sender: UIRefreshControl) {
        self.fetchTrainingWeek()
    }
    
    func fetchTrainingWeek() {
        let trainingDaysOperation = TherapyWeekManager.sharedInstance.trainingDaysOperationWith { [weak self] (result) in
            self?.refreshControl.endRefreshing()
            
            switch result {
            case .success:
                self?.setupExercises()
                self?.collectionView?.reloadData()
            case .failure(let error):
                guard let casparError = error as? CasparError else {
                    assertionFailure()
                    self?.presentUnknownErrorAlert()
                    return
                }
                
                self?.presentCasparErrorAlert(error: casparError)
            }
        }
        operationQueue.addOperation(trainingDaysOperation)
    }
    
    func setupExercises() {
        
        guard let therapyWeek = TherapyWeekManager.sharedInstance.therapyWeek else {
            return
        }
        
        self.viewModels.removeAll()
        
        let orderedExercises = therapyWeek.exercisesGroupedById.sorted { (firstTuple, secondTuple) -> Bool in
            if let firstSessionNumber = firstTuple.value.first?.sessionNumber,
                let secondSessionNumber = secondTuple.value.first?.sessionNumber {
                return firstSessionNumber < secondSessionNumber
            } else {
                return true
            }
        }
        
        orderedExercises.forEach({ (_, exerciseSessions) in
            
            // TODO: Fill the self.viewModels array with objects of type ExerciseCollectionViewModel
            // orderedExercises represents all the exercises sessions in a therapy week grouped by the exercise id
            
            // Initialize ExerciseCollectionViewModel with
            // 1. first session that is active (isActive == true), or any if there is no active sessions for this exercise id
            // 2. total sessions count
            // 3. completed sessions (isCompleted == true) count
            
            // This is how the screen should look like given the mocked response https://i.snipboard.io/yUiT6w.jpg
            
        })
    }
    
    private func fetchExerciseConfigWith(exerciseBasicInfo: Exercise, onCompletion: ((Exercise?, ExerciseConfiguration?) -> Void)?) {
        CasparAPIClient.fetchExerciseConfigWith(id: exerciseBasicInfo.configurationId) { [weak self] (result) in
            switch result {
            case .success(let dataTaskCompletion):
                guard let jsonData = dataTaskCompletion.data else {
                    onCompletion?(nil, nil)
                    return
                }
                do {
                    let exerciseConfiguration = try JSONDecoder().decode(ExerciseConfiguration.self, from: jsonData)
                    
                    onCompletion?(exerciseBasicInfo, exerciseConfiguration)
                } catch {
                    print(error)
                    onCompletion?(exerciseBasicInfo, nil)
                }
                
            case .failure(let error, _):
                self?.presentCasparErrorAlert(error: error, okHandler: {
                    onCompletion?(nil, nil)
                })
            }
        }
    }
    
    private func fetchExerciseCategories() {
        let operation = ExerciseCategoriesOperation { [weak self] (result) in
            switch result {
            case .success(let exerciseCategoriesCollection):
                TherapyWeekManager.sharedInstance.exerciseCategories = exerciseCategoriesCollection
            case .failure(let error):
                self?.presentCasparErrorAlert(error: error as! CasparError)
            }
        }
        operationQueue.addOperation(operation)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ExerciseCollectionViewCell.self), for: indexPath) as? ExerciseCollectionViewCell else {
            assertionFailure()
            return UICollectionViewCell()
        }
        
        let viewModel = viewModels[indexPath.item]
        
        viewModel.isLastInSection = indexPath.item == (collectionView.numberOfItems(inSection: indexPath.section) - 1)
        viewModel.configure(cell: cell)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.item]
        guard viewModel.hasSessionsToDo else {
            return
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ExerciseCollectionViewCell else {
            assertionFailure()
            return
        }
        
        cell.isLoading = true
        
        fetchExerciseCategories()
        fetchExerciseConfigWith(exerciseBasicInfo: viewModel.exercise) { [weak self] (exercise, exerciseConfiguration) in
            cell.isLoading = false
            
            guard let exercise = exercise, let exerciseConfiguration = exerciseConfiguration else {
                self?.presentErrorAlertWithOk(message: NSLocalizedString("ExerciseConfig_Error_CorruptedData", comment: ""))
                return
            }
            
            self?.showExerciseContainerWith(exerciseBasicInfo: exercise, exerciseConfiguration: exerciseConfiguration)
        }
        
    }
    
    func showExerciseContainerWith(exerciseBasicInfo: Exercise, exerciseConfiguration: ExerciseConfiguration) {
        let exerciseContainerViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: SingleExerciseContainerViewController.self)) as! SingleExerciseContainerViewController
        exerciseContainerViewController.exerciseBasicInfo = exerciseBasicInfo
        exerciseContainerViewController.exerciseConfiguration = exerciseConfiguration
        exerciseContainerViewController.exerciseCategoriesCollection = TherapyWeekManager.sharedInstance.exerciseCategories
        exerciseContainerViewController.delegate = self
        
        self.customPresentationController = CustomPresentationController(presentedViewController: exerciseContainerViewController, presenting: self)
        exerciseContainerViewController.transitioningDelegate = self.customPresentationController
        exerciseContainerViewController.modalPresentationCapturesStatusBarAppearance = true
        
        self.present(exerciseContainerViewController, animated: true, completion: {
            self.shouldHideStatusBar = true
        })
    }
    
}

extension ExercisesListViewController: SingleExerciseContainerViewControllerDelegate {
    
    func singleExerciseContainerViewControllerDidClose(_ viewController: SingleExerciseContainerViewController) {
        self.dismiss(animated: true, completion: nil)
        self.customPresentationController = nil
        self.fetchTrainingWeek()
    }
    
}

extension ExercisesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
    }
    
}

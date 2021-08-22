//
//  AlertsExtension.swift
//  CH_PatientApp
//
//  Created by Rui Miguel on 20/2/17.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(withTitle title: String?, message: String?, actions: [UIAlertAction], completion: (() -> Void)? = nil) {
        let alert = alertController(withTitle: title, message: message, actions: actions, style: .alert)
        present(alert, animated: true, completion: completion)
    }
    
    func presentCasparErrorAlert(error: CasparError, customMessage: String? = nil, okHandler: (() -> Void)? = nil) {
        let dismissAction = UIAlertAction(title: Constants.Alerts.okButtonTitle, style: .default, handler: { _ in
            okHandler?()
        })
        
        let alert = alertController(withTitle: Constants.Alerts.errorTitle,
                                    message: messageFromError(error, customMessage: customMessage),
                                    actions: [dismissAction], style: .alert)
        present(alert, animated: true, completion: nil)
    }
    
    func messageFromError(_ error: CasparError, customMessage: String?) -> String {
        if error.isNetworkUnreachable {
            return NSLocalizedString("error_message_no_connection", comment: "")
        } else if error.isNetworkTimeout {
            Log.error(error)
            return NSLocalizedString("error_message_timeout", comment: "")
        } else if error.isSerializationError {
            Log.error(error)
        }
        
        return customMessage ?? NSLocalizedString("error_message_unknown", comment: "")
    }
    
    func presentActionSheet(withTitle title: String?, message: String?, actions: [UIAlertAction], sourceView: UIView, sourceRect: CGRect) {
        
        let alert = alertController(withTitle: title, message: message, actions: actions, style: .actionSheet)
        
        if let presentationController = alert.popoverPresentationController {
            presentationController.sourceRect = sourceRect
            presentationController.sourceView = sourceView
        }
        present(alert, animated: true, completion: nil)
    }
    
    private func alertController(withTitle title: String?, message: String?, actions: [UIAlertAction], style: UIAlertController.Style) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        actions.forEach {
            alertController.addAction($0)
        }
        
        return alertController
    }
    
    func presentErrorAlert(message: String?, actions: [UIAlertAction]) {
        presentAlert(withTitle: Constants.Alerts.errorTitle, message: message, actions: actions)
    }
    
    func presentErrorAlertWithOk(message: String?, okHandler: (() -> Void)? = nil) {
        let dismissAction = UIAlertAction(title: Constants.Alerts.okButtonTitle, style: .default, handler: { _ in
            okHandler?()
        })
        presentAlert(withTitle: Constants.Alerts.errorTitle, message: message, actions: [dismissAction])
    }
    
    func presentOkAlert(withTitle title: String, message: String, okHandler: (() -> Void)?) {
        let dismissAction = UIAlertAction(title: Constants.Alerts.okButtonTitle, style: .default, handler: { _ in
            okHandler?()
        })
        presentAlert(withTitle: title, message: message, actions: [dismissAction])
    }
    
    func presentUnknownErrorAlert(whenOkIsTapped okHandler: (() -> Void)? = nil) {
        presentOkAlert(withTitle: Constants.Alerts.errorTitle,
                       message: NSLocalizedString("error_message_unknown", comment: ""),
                       okHandler: okHandler)
    }
    
    /// Shows error by presenting alert controller
    /// - Parameter error: Error to be presented
    func showErrorAlert(error: Error) {
        guard let casparError = error as? CasparError else {
            assertionFailure()
            presentUnknownErrorAlert()
            return
        }
        
        if casparError.code == CasparErrorCode.invalidCredentials.rawValue {
            presentErrorAlertWithOk(message: Constants.ErrorMessages.invalidCredentials)
        } else {
            presentCasparErrorAlert(error: casparError)
        }
    }
}

extension UIAlertAction {
    
    static var cancel: UIAlertAction {
        return UIAlertAction(title: Constants.Alerts.cancelButtonTitle, style: .cancel, handler: nil)
    }
    
    static var okAction: UIAlertAction {
        return UIAlertAction(title: Constants.Alerts.okButtonTitle, style: .cancel, handler: nil)
    }
    
}

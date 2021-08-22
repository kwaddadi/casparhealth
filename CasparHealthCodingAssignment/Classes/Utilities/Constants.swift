//
//  Constants.swift
//  CH_PatientApp
//
//  Created by Rui Miguel on 1/2/17.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import UIKit

struct Constants {
    
    // Hack around the fact that backend expects non-standard language codes for simplified Chinese (cn) and Hong Kong traditional Chinese (zh)
    enum LocaleIdentifier: String {
        case english = "en"
        case german = "de"
        case chineseSimplified = "cn"
        case chineseTraditional = "zh"
        
        init(fromLocale locale: Locale) {
            let proposedLanguageCode = locale.languageCode ?? "en"
            let finalLanguageCode: String
            switch locale.scriptCode {
            case .none:
                finalLanguageCode = proposedLanguageCode
            case .some(let scriptCode):
                switch scriptCode {
                case "Hant": // Traditional chinese
                    finalLanguageCode = "zh"
                case "Hans": // Simplified chinese
                    finalLanguageCode = "cn"
                default:
                    finalLanguageCode = proposedLanguageCode
                }
            }
            // Default to english in case locale wasn't found
            self = LocaleIdentifier(rawValue: finalLanguageCode) ?? .english
        }
    }
    
    static var convertedLocaleIdentifier: LocaleIdentifier {
        return LocaleIdentifier(fromLocale: Locale.current)
    }
       
    struct ErrorMessages {
        static let invalidCredentials = NSLocalizedString("Invalid login credentials.", comment: "Error message when invalid username/password pair was entered")
        static let repetitionIsNotEqual = NSLocalizedString("New password and repetition are not the same.", comment: "")
        static let updatePatientDetailsFailed = NSLocalizedString("Couldn't update your details.", comment: "Error message when updating patient details fails")
    }
    
    struct Alerts {
        static let errorTitle = NSLocalizedString("Error", comment: "Alert title when an error occurs")
        static let sorryTitle = NSLocalizedString("Sorry", comment: "General alert title when something else went wrong")
        static let okButtonTitle = NSLocalizedString("Ok", comment: "Button title used in an alert, to acknowledge information and dismiss it")
        static let laterButtonTitle = NSLocalizedString("Later", comment: "Button title used in an alert, to acknowledge information and dismiss it")
        static let settingsButtonTitle = NSLocalizedString("Settings", comment: "Button title for device settings redirect")
        static let cancelButtonTitle = NSLocalizedString("Cancel", comment: "Title for the cancel button in an alert")
        static let passwordUpdatedMessage = NSLocalizedString("Password updated", comment: "Short message to inform of successfully updated password")
    }
    
    struct Design {
        static let insetForViewsWithText: CGFloat = 10
        static let textFieldBaselineHeight: CGFloat = 1
        static let myDayTherapyItemNameLabelFontSize: CGFloat = 15
        static func resize(_ bounds: CGRect, toProportion proportion: CGFloat) -> CGRect {
            // Proportion of arrow symbol's bounds in relation to button
            let width = bounds.width * proportion
            let height = bounds.height * proportion
            let originX = (bounds.width/2) - (width/2) // Center horizontally
            let originY = (bounds.height/2) - (height/2) // Center vertically
            return CGRect(x: originX, y: originY, width: width, height: height)
        }
    }
    
    struct Cell {
        static let reuseIdentifier = "Cell"
        static let downloadingContent = NSLocalizedString("Loading...", comment: "Displayed When loading content from the server")
        static let dimmedAlpha: CGFloat = 0.3
    }
    
    struct SegueIdentifier {
        static let segueToTermsDetailViewController = "segueToTermsDetailViewController"
        static let weekDaySelectorEmbedSegue = "weekDaySelectorEmbedSegue"
        static let cellToExerciseDetailSegue = "cellToExerciseDetailSegue"
        static let toPerformExerciseSegue = "performExerciseViewControllerSegue"
        static let exerciseInstructions = "exerciseInstructionsSegue"
        static let exerciseSettings = "exerciseSettingsSegue"
        static let embedVideoPlayerViewController = "embedVideoPlayerViewController"
        static let embedVideoCaptureViewController = "embedVideoCaptureViewController"
    }
    
    struct CommonStrings {
        static let emailAddress = NSLocalizedString("Email or Caspar ID", comment: "Used as a placeholder in the sign in field, before the user types anything.")
        static let pushNotifications = NSLocalizedString("Notifications", comment: "")
        static let therapistChat = NSLocalizedString("Therapeuten-Chat", comment: "")
        static let feedback = NSLocalizedString("Feedback", comment: "Title for feedback screen")
        static let imprint = NSLocalizedString("Imprint", comment: "Title for about the app section")
        static let legal = NSLocalizedString("Legal", comment: "Title for about the app section")
        static let patientConsent = NSLocalizedString("LegalDocuments_List_CasparPatientConsent", comment: "Title for the patient consent button on legal documents screen")
        static let facilityTerms = NSLocalizedString("LegalDocuments_List_FacilityTerms", comment: "Title for the facility terms button on legal documents screen")
        static let profile = NSLocalizedString("Contact details", comment: "Profile screen and section title")
        static let clinicInfo = NSLocalizedString("More_ClinicInfo", comment: "Clinic info button on More screen")
        static let signIn = NSLocalizedString("Sign in", comment: "")
        static let signOut = NSLocalizedString("Sign out", comment: "").uppercased()
        static let changePassword = NSLocalizedString("Change Password", comment: "Confirm password change, button title")
        static let continueTitle = NSLocalizedString("Continue", comment: "")
        static let doneButtonTitle = NSLocalizedString("Done", comment: "Title for a done button")
        static let finishExerciseButtonTitle = NSLocalizedString("Finish Exercise", comment: "Title for a Finish exercise button")
        static let next = NSLocalizedString("Next", comment: "Button title to move to the next feedback section")
        static let start = NSLocalizedString("Start", comment: "Title for start button")
        static let startExerciseButtonTitle = NSLocalizedString("Start Exercise", comment: "Title for start exercise button")
        static let noEmailAddressText = NSLocalizedString("No Email Address", comment: "Message to display in email field when user doesn't have an email address")
        static let casparIDPlaceholder = NSLocalizedString("Caspar ID", comment: "")
        static let emailPlaceholder = NSLocalizedString("Email address", comment: "")
    }
    
    struct Placeholders {
        static let newPassword = NSLocalizedString("New Password", comment: "")
        static let repeatNewPassword = NSLocalizedString("Repeat New Password", comment: "")
    }
    
    struct UserInfo {
        static let enabledKey = "enabled"
    }
}

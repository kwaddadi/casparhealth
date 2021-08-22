//
//  FontsExtension.swift
//  CasparHealth
//
//  Created by Kris George Manimala on 21.03.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    static func roboto(forTextStyle textStyle: UIFont.TextStyle = .body, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont(name: self.robotoFontName(forWeight: weight), size: UIFont.preferredFont(forTextStyle: textStyle).pointSize)!
    }
    
    static func roboto(withSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont(name: self.robotoFontName(forWeight: weight), size: size)!
    }
    
    private static func robotoFontName(forWeight weight: UIFont.Weight) -> String {
        switch weight {
        case .bold:
            return "Roboto-Bold"
        case .semibold:
            return "Roboto-Medium"
        case .medium:
            return "Roboto-Medium"
        case .light:
            return "Roboto-Light"
        default:
            return "Roboto-Regular"
        }
    }
    
    var italic: UIFont {
        return with(traits: .traitItalic)
    }
    
    var boldItalic: UIFont {
        return with(traits: [.traitBold, .traitItalic])
    }
    
    func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
            return self
        }
        
        return UIFont(descriptor: descriptor, size: 0)
    }
}

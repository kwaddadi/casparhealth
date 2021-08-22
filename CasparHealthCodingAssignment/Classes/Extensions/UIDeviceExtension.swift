//
//  UIDeviceExtension.swift
//  CasparHealth
//
//  Created by Gennadii Berezovskii on 02.07.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit

public enum Model : String {
    case simulator   = "simulator/sandbox",
    iPod1            = "iPod 1",
    iPod2            = "iPod 2",
    iPod3            = "iPod 3",
    iPod4            = "iPod 4",
    iPod5            = "iPod 5",
    iPodTouch5       = "iPod5,1",
    iPodTouch6       = "iPod7,1",
    iPad4            = "iPad 4",
    iPhone4          = "iPhone 4",
    iPhone4S         = "iPhone 4S",
    iPhone5          = "iPhone 5",
    iPhone5s         = "iPhone 5S",
    iPhone5c         = "iPhone 5C",
    iPadMini2        = "iPad Mini 2",
    iPadMini3        = "iPad Mini 3",
    iPadAir1         = "iPad Air 1",
    iPadAir2         = "iPad Air 2",
    iPadPro9_7       = "iPad Pro 9.7\"", // swiftlint:disable:this identifier_name
    iPadPro10_5      = "iPad Pro 10.5\"", // swiftlint:disable:this identifier_name
    iPadPro12_9      = "iPad Pro 12.9\"", // swiftlint:disable:this identifier_name
    iPhone6          = "iPhone 6",
    iPhone6Plus      = "iPhone 6 Plus",
    iPhone6s         = "iPhone 6S",
    iPhone6sPlus     = "iPhone 6S Plus",
    iPhoneSE         = "iPhone SE",
    iPhone7          = "iPhone 7",
    iPhone7Plus      = "iPhone 7 Plus",
    iPhone8          = "iPhone 8",
    iPhone8Plus      = "iPhone 8 Plus",
    iPhoneX          = "iPhone X",
    iPhoneXS         = "iPhone XS",
    iPhoneXR         = "iPhone XR",
    iPhoneXSMax      = "iPhone XS Max",
    unrecognized     = "?unrecognized?"
}

public extension UIDevice {
    
    private func mapToDevice(identifier: String) -> Model { // swiftlint:disable:this cyclomatic_complexity
        switch identifier {
        case "iPod5,1": return .iPodTouch5
        case "iPod7,1": return .iPodTouch6
        
        case "iPhone5,1", "iPhone5,2": return .iPhone5
        case "iPhone5,3", "iPhone5,4": return .iPhone5c
        case "iPhone6,1", "iPhone6,2": return .iPhone5s
        case "iPhone7,2": return .iPhone6
        case "iPhone7,1": return .iPhone6Plus
        case "iPhone8,1": return .iPhone6s
        case "iPhone8,2": return .iPhone6sPlus
        case "iPhone8,4": return .iPhoneSE
        case "iPhone9,1", "iPhone9,3": return .iPhone7
        case "iPhone9,2", "iPhone9,4": return .iPhone7Plus
        case "iPhone10,1", "iPhone10,4": return .iPhone8
        case "iPhone10,2", "iPhone10,5": return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6": return .iPhoneX
        case "iPhone11,2": return .iPhoneXS
        case "iPhone11,4", "iPhone11,6": return .iPhoneXSMax
        case "iPhone11,8": return .iPhoneXR
            
        case "iPad3,4", "iPad3,5", "iPad3,6" : return .iPad4
        case "iPad4,1"  : return .iPadAir1
        case "iPad4,2"  : return .iPadAir2
        case "iPad4,4", "iPad4,5", "iPad4,6" : return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9" : return .iPadMini3
        case "iPad6,3", "iPad6,4", "iPad6,11", "iPad6,12" : return .iPadPro9_7
        case "iPad6,7", "iPad6,8" : return .iPadPro12_9
        case "iPad7,3", "iPad7,4" : return .iPadPro10_5
            
        case "i386", "x86_64": return mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS")
        default: return .unrecognized
        }

    }
    
    var type: Model {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in
                String.init(validatingUTF8: ptr)
            }
        }
        
        return mapToDevice(identifier: String.init(validatingUTF8: modelCode!)!)
    }

}

public extension UIDevice {
    
    enum WidthClass {
        case compact
        case regular
        case wide
        case pad
    }
    
    var widthClass: WidthClass {
        switch self.type {
        case .iPhone5s, .iPhoneSE, .iPhone5c, .iPhone5:
            return .compact
        case .iPhone6, .iPhone6s, .iPhone7, .iPhone8, .iPhoneX, .iPhoneXS:
            return .regular
        case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus, .iPhoneXSMax, .iPhoneXR:
            return .wide
        case .iPad4, .iPadAir1, .iPadAir2, .iPadMini2, .iPadMini3, .iPadPro9_7, .iPadPro10_5, .iPadPro12_9:
            return .pad
        default:
            return .regular
        }
    }
    
    var isPhone: Bool {
        return self.userInterfaceIdiom == .phone
    }
    
    var isPad: Bool {
        return self.userInterfaceIdiom == .pad
    }
    
    var isSmallPhone: Bool {
        return widthClass == .compact
    }
    
    var isRegularPhone: Bool {
        return widthClass == .regular
    }
    
    var isWidePhone: Bool {
        return widthClass == .wide
    }

}

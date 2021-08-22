//
//  Style.swift
//  CasparHealth
//
//  Created by Rui Miguel on 1/2/17.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import UIKit

struct Style {
    struct Layout {
        static let cornerRadius: CGFloat = 5
    }
}

struct ColorSheet {
    
    // MARK: Grey Scale
    
    static var text: UIColor {
        return .white
    }
    static var charcoal: UIColor {
        return #colorLiteral(red: 0.1254901961, green: 0.1254901961, blue: 0.1254901961, alpha: 1) // #202020
    }
    static var grey1: UIColor {
        return #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 1) // #565656
    }
    static var grey2: UIColor {
        return #colorLiteral(red: 0.4901960784, green: 0.4901960784, blue: 0.4901960784, alpha: 1) // 7D7D7D
    }
    static var grey3: UIColor {
        return #colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1) // #848484
    }
    static var grey4: UIColor {
        return #colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.5764705882, alpha: 1) // #939393
    }
    static var grey5: UIColor {
        return #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6823529412, alpha: 1) // #AEAEAE
    }
    static var grey6: UIColor {
        return #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8392156863, alpha: 1) // #D6D6D6
    }
    static var lightGrey1: UIColor {
        return #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1) // #EDEDED
    }
    static var lightGrey2: UIColor {
        return #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1) // #F1F1F1
    }
    static var lightGrey3: UIColor {
        return #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1) // #F7F7F7
    }
    static var lightGrey4: UIColor {
        return #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1) // #FBFBFB
    }
    
    // MARK: Colorful Scale
    
    static var darkBurgundy: UIColor {
        return #colorLiteral(red: 0.4941176471, green: 0.03921568627, blue: 0.05490196078, alpha: 1) // #7E0A0E
    }
    static var orangeRoughy: UIColor {
        return #colorLiteral(red: 0.7098039216, green: 0.2823529412, blue: 0.1019607843, alpha: 1) // #B5481A
    }
    static var carnation: UIColor {
        return #colorLiteral(red: 0.9764705882, green: 0.4078431373, blue: 0.3529411765, alpha: 1) // #F9685A
    }
    static var salmon: UIColor {
        return #colorLiteral(red: 0.9921568627, green: 0.5647058824, blue: 0.462745098, alpha: 1) // #FD9076
    }
    static var yourPink: UIColor {
        return #colorLiteral(red: 1, green: 0.7803921569, blue: 0.7215686275, alpha: 1) // #FFC7B8
    }
    static var orangePeel: UIColor {
        return #colorLiteral(red: 1, green: 0.5960784314, blue: 0, alpha: 1) // #FF9800
    }
    static var koromiko: UIColor {
        return #colorLiteral(red: 0.9921568627, green: 0.7411764706, blue: 0.4039215686, alpha: 1) // #FDBD67
    }
    static var negroni: UIColor {
        return #colorLiteral(red: 1, green: 0.8980392157, blue: 0.8117647059, alpha: 1) // #FFE1C9
    }
    static var iceberg: UIColor {
        return #colorLiteral(red: 0.8705882353, green: 1, blue: 0.9490196078, alpha: 1) // #DEFFF2
    }
    static var mintTulip: UIColor {
        return #colorLiteral(red: 0.7764705882, green: 0.9607843137, blue: 0.937254902, alpha: 1) // #C6F5EF
    }
    
    static var turquoise: UIColor {
        return #colorLiteral(red: 0.2784313725, green: 0.8901960784, blue: 0.6588235294, alpha: 1) // #47E3A8
    }
    static var niagara: UIColor {
        return #colorLiteral(red: 0.02745098039, green: 0.6745098039, blue: 0.6705882353, alpha: 1) // #07ACAB
    }
    static var turquoiseBlue: UIColor {
        return #colorLiteral(red: 0.3137254902, green: 0.8862745098, blue: 0.7843137255, alpha: 1) // #50E2C8
    }
    static var charlotte: UIColor {
        return #colorLiteral(red: 0.7058823529, green: 0.9764705882, blue: 0.8980392157, alpha: 1) // #B4F9E5
    }
    static var linkWater: UIColor {
        return #colorLiteral(red: 0.8705882353, green: 0.9098039216, blue: 0.968627451, alpha: 1) // #DEE8F7
    }
    static var aquaHaze: UIColor {
        return #colorLiteral(red: 0.937254902, green: 0.9568627451, blue: 0.9647058824, alpha: 1) // #EFF4F6
    }
    static var bayOfMany: UIColor {
        return #colorLiteral(red: 0.1607843137, green: 0.1725490196, blue: 0.5098039216, alpha: 1) // #292C82
    }
    static var periwinkle: UIColor {
        return #colorLiteral(red: 0.8235294118, green: 0.8588235294, blue: 0.9960784314, alpha: 1) // #D2DBFE
    }
    static var cornflowerBlue: UIColor {
        return #colorLiteral(red: 0.3843137255, green: 0.4549019608, blue: 0.9098039216, alpha: 1) // #6274E8
    }
    static var ceruleanBlue: UIColor {
        return #colorLiteral(red: 0.2039215686, green: 0.2862745098, blue: 0.8, alpha: 1) // #3449CC
    }
    static var dodgerBlue: UIColor {
        return #colorLiteral(red: 0.231372549, green: 0.3882352941, blue: 0.9843137255, alpha: 1) // #3B63FB
    }
    static var royalBlue: UIColor {
        return #colorLiteral(red: 0.2196078431, green: 0.3647058824, blue: 1, alpha: 1) // #385DFF
    }
    static var stratos: UIColor {
        return #colorLiteral(red: 0.003921568627, green: 0.03529411765, blue: 0.2509803922, alpha: 1) // #010940
    }
    static var ghost: UIColor {
        return #colorLiteral(red: 0.7450980392, green: 0.7529411765, blue: 0.8117647059, alpha: 1) // #BEC0CF
    }
    static var manatee: UIColor {
        return #colorLiteral(red: 0.568627451, green: 0.5843137255, blue: 0.6666666667, alpha: 1) // #9195AA
    }
    
    // Pain Levels
    
    static var fountainBlue: UIColor {
        return #colorLiteral(red: 0.3176470588, green: 0.7450980392, blue: 0.7254901961, alpha: 1) // #51BEB9
    }
    static var oceanGreen: UIColor {
        return #colorLiteral(red: 0.2862745098, green: 0.6392156863, blue: 0.5294117647, alpha: 1) // #49A387
    }
    static var chateauGreen: UIColor {
        return #colorLiteral(red: 0.2980392157, green: 0.7019607843, blue: 0.3843137255, alpha: 1) // #4CB362
    }
    static var mantis: UIColor {
        return #colorLiteral(red: 0.5490196078, green: 0.7882352941, blue: 0.3098039216, alpha: 1) // #8CC94F
    }
    static var wattle: UIColor {
        return #colorLiteral(red: 0.8039215686, green: 0.8705882353, blue: 0.368627451, alpha: 1) // #CDDE5E
    }
    static var yellow: UIColor {
        return #colorLiteral(red: 0.9254901961, green: 0.8039215686, blue: 0.4235294118, alpha: 1) // #ECCD6C
    }
    static var confetti: UIColor {
        return #colorLiteral(red: 0.9058823529, green: 0.8549019608, blue: 0.3803921569, alpha: 1) // #E7DA61
    }
    static var goldenSand: UIColor {
        return #colorLiteral(red: 0.9098039216, green: 0.8156862745, blue: 0.3803921569, alpha: 1) // #E8D061
    }
    static var porsche: UIColor {
        return #colorLiteral(red: 0.9098039216, green: 0.7333333333, blue: 0.3803921569, alpha: 1) // #E8BB61
    }
    static var pink: UIColor {
        return #colorLiteral(red: 0.862745098, green: 0.537254902, blue: 0.5058823529, alpha: 1) // #DC8981
    }
    static var terracotta: UIColor {
        return #colorLiteral(red: 0.8980392157, green: 0.4588235294, blue: 0.3803921569, alpha: 1) // #E57561
    }
    static var roman: UIColor {
        return #colorLiteral(red: 0.8549019608, green: 0.3921568627, blue: 0.3568627451, alpha: 1) // #DA645B
    }
    static var matrix: UIColor {
        return #colorLiteral(red: 0.7058823529, green: 0.3450980392, blue: 0.3019607843, alpha: 1) // #B4584D
    }
    
    static var exerciseControlsBackground: UIColor {
        return UIColor.gray.withAlphaComponent(0.5)
    }

}

extension UIColor {
    
    static var submitButtonText: UIColor {
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // #FFFFFF
    }
    
    static var messageFromTherapist: UIColor {
        return ColorSheet.aquaHaze
    }
    static var messageFromPatient: UIColor {
        return ColorSheet.linkWater
    }
    static var messageUnsent: UIColor {
        return ColorSheet.yourPink
    }
    static var casparBlue: UIColor {
        return ColorSheet.ceruleanBlue
    }
    static var casparGreen: UIColor {
        return ColorSheet.turquoiseBlue
    }
    static var setsRepsContainerBackground: UIColor {
        return ColorSheet.lightGrey1
    }
    static var setsRepsLabelText: UIColor {
        return ColorSheet.grey3
    }
    static var selectedSpeedPanelAndSetsRepsCountdown: UIColor {
        return ColorSheet.cornflowerBlue
    }
    static var deSelectedSpeedPanel: UIColor {
        return ColorSheet.ghost
    }
    static var cameraRelatedButtonBlue: UIColor {
        return ColorSheet.ceruleanBlue
    }
    static var cameraRelatedButtonRed: UIColor {
        return ColorSheet.carnation
    }
    static var welcomeDarkText: UIColor {
        return ColorSheet.grey1
    }
    static var navigationLightGray: UIColor {
        return ColorSheet.lightGrey3
    }
    static var exerciseCurveViewBackground: UIColor {
        return ColorSheet.lightGrey3
    }
    static var nonSelectedTab: UIColor {
        return ColorSheet.grey5
    }
    static var grayText: UIColor {
        return ColorSheet.grey2
    }
    static var accent: UIColor {
        return ColorSheet.orangePeel
    }
    static var lightAccent: UIColor {
        return ColorSheet.negroni
    }
    static var primary: UIColor {
        return ColorSheet.niagara
    }
    static var exerciseInfoSetsRepsCircle: UIColor {
        return ColorSheet.mintTulip
    }
    static var primaryText: UIColor {
        return ColorSheet.charcoal
    }
    static var secondaryText: UIColor {
        return ColorSheet.grey4
    }
    static var equipmentTagBackground: UIColor {
        return ColorSheet.lightGrey1
    }
    static var equipmentTagText: UIColor {
        return ColorSheet.manatee
    }
    static var exerciseInfoButton: UIColor {
        return ColorSheet.dodgerBlue
    }
    static var exerciseInfoLightButton: UIColor {
        return ColorSheet.royalBlue
    }
    static var exerciseInstructionsBackground: UIColor {
        return ColorSheet.stratos
    }
    static var separator: UIColor {
        return ColorSheet.lightGrey2
    }
    static var shadow: UIColor {
        return ColorSheet.grey6
    }
    static var feedbackButtonTitle: UIColor {
        return ColorSheet.orangeRoughy
    }
    static var skipButtonBackground: UIColor {
        return ColorSheet.salmon
    }
    static var skipButtonTitle: UIColor {
        return ColorSheet.darkBurgundy
    }
    
    // MARK: Pain levels
    
    static var painLevel0: UIColor {
        return ColorSheet.fountainBlue
    }
    static var painLevel1: UIColor {
        return ColorSheet.oceanGreen
    }
    static var painLevel2: UIColor {
        return ColorSheet.chateauGreen
    }
    static var painLevel3: UIColor {
        return ColorSheet.mantis
    }
    static var painLevel4: UIColor {
        return ColorSheet.wattle
    }
    static var painLevel5: UIColor {
        return ColorSheet.confetti
    }
    static var painLevel6: UIColor {
        return ColorSheet.goldenSand
    }
    static var painLevel7: UIColor {
        return ColorSheet.porsche
    }
    static var painLevel8: UIColor {
        return ColorSheet.terracotta
    }
    static var painLevel9: UIColor {
        return ColorSheet.roman
    }
    static var painLevel10: UIColor {
        return ColorSheet.matrix
    }
    
    // MARK: Today Activities
    
    static var todayActivitiesCountBackground: UIColor {
        return ColorSheet.koromiko
    }
    static var todayActivityText: UIColor {
        return ColorSheet.grey1
    }
    static var todayActivityControlHeader: UIColor {
        return ColorSheet.bayOfMany
    }
    static var todayActivityControlOutline: UIColor {
        return ColorSheet.periwinkle
    }
    
    static var stepsGoalReached: UIColor {
        return ColorSheet.charlotte
    }
    static var stepsGoalNotReached: UIColor {
        return ColorSheet.negroni
    }
    static var stepsGoalTarget: UIColor {
        return ColorSheet.orangePeel
    }
    
    // MARK: New Weekly Therapy
    
    static var therapyWeekInfoTextColor: UIColor {
        return ColorSheet.grey1
    }
    
    static var totalMinutesTextColor: UIColor {
        return ColorSheet.grey1
    }
    
    static var trainingProgressColor: UIColor {
        return ColorSheet.niagara
    }
    
    static var knowledgeAndWellbeingProgressColor: UIColor {
        return ColorSheet.yellow
    }
    
    static var stepsProgressColor: UIColor {
        return ColorSheet.pink
    }
    
    // MARK: Therapy week
    
    static var exersiceListCompleted: UIColor {
        return ColorSheet.turquoise
    }
    
    static var knowledgeListCompleted: UIColor {
        return ColorSheet.iceberg
    }
    static var knowledgeListToWatch: UIColor {
        return ColorSheet.lightGrey4
    }

}

extension UIColor {
    public func colorWithHue(_ newHue: CGFloat) -> UIColor {
        var saturation: CGFloat = 1.0, brightness: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getHue(nil, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: newHue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    public func colorWithSaturation(_ newSaturation: CGFloat) -> UIColor {
        var hue: CGFloat = 1.0, brightness: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getHue(&hue, saturation: nil, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: newSaturation, brightness: brightness, alpha: alpha)
    }
    public func colorWithBrightness(_ newBrightness: CGFloat) -> UIColor {
        var hue: CGFloat = 1.0, saturation: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getHue(&hue, saturation: &saturation, brightness: nil, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
    public func colorWithAlpha(_ newAlpha: CGFloat) -> UIColor {
        var hue: CGFloat = 1.0, saturation: CGFloat = 1.0, brightness: CGFloat = 1.0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: newAlpha)
    }
    public func colorWithHighlight(_ highlight: CGFloat) -> UIColor {
        var red: CGFloat = 1.0, green: CGFloat = 1.0, blue: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-highlight) + highlight, green: green * (1-highlight) + highlight, blue: blue * (1-highlight) + highlight, alpha: alpha * (1-highlight) + highlight)
    }
    public func colorWithShadow(_ shadow: CGFloat) -> UIColor {
        var red: CGFloat = 1.0, green: CGFloat = 1.0, blue: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-shadow), green: green * (1-shadow), blue: blue * (1-shadow), alpha: alpha * (1-shadow) + shadow)
    }
}

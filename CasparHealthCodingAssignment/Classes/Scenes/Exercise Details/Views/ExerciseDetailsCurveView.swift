//
//  ExerciseDetailsCurveView.swift
//  CasparHealth
//
//  Created by Gennadii Berezovskii on 26.06.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit

class ExerciseDetailsCurveView: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addCurve(to: CGPoint(x: 0, y: rect.height),
                      controlPoint1: CGPoint(x: rect.width / 2 + 20, y: rect.height / 2),
                      controlPoint2: CGPoint(x: rect.width / 2 - 20, y: rect.height / 2))
        path.close()
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.exerciseCurveViewBackground.cgColor
        layer.path = path.cgPath
        layer.frame = self.bounds
        
        self.layer.addSublayer(layer)
    }

}

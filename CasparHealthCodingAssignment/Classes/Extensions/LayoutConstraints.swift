//
//  LayoutConstraints.swift
//  CH_PatientApp
//
//  Created by Rui Miguel on 5/2/17.
//  Copyright © 2017 GOREHA GmbH. All rights reserved.
//

import UIKit

extension UIView {
    
    // swiftlint:disable all
    
    /**
     Add several constraints to a view.
     
     - Precondition: The number of suppied constants must be equal to the number of supplied attributes.
     
     - Parameters:
       - attributes: Which `NSLayoutAttribute` values you want to match between views participating in constraint.
       - constants: Constants to apply to the constraints.
       - relation: `NSLayoutRelation` between items. Default value is .Equal.
     */
    func addConstraints(_ attributes: NSLayoutConstraint.Attribute..., relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1.0, item item1: UIView, toItem item2: Any?, constants: [CGFloat]) {
        
        addConstraints(attributes: attributes, relation: relation, item: item1, toItem: item2, multiplier: multiplier, constants: constants)
    }
    
    /// Add several constraints to a view, aplying the same constant to all.
    func addConstraints(_ attributes: NSLayoutConstraint.Attribute..., item item1: UIView, toItem item2: Any?, multiplier: CGFloat = 1.0, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0) {
        let constants = (0..<attributes.count).map { _ in constant }
        addConstraints(attributes: attributes, relation: relation, item: item1, toItem: item2, multiplier: multiplier, constants: constants)
    }
    
    /// Pin first item to all sides of second item, optionally with an equal distance from all sides.
    func addConstraintsForAllSides(item item1: UIView, toItem item2: Any?, distance constant: CGFloat = 0) {
        addConstraints(.top, .bottom, .left, .right, item: item1, toItem: item2, constants: [constant, -constant, constant, -constant])
    }
    
    func addConstraintsForAllSides(toView view: UIView, distance constant: CGFloat = 0) {
        addConstraints(.top, .bottom, .left, .right, item: self, toItem: view, constants: [constant, -constant, constant, -constant])
    }
    
    fileprivate func addConstraints(attributes: [NSLayoutConstraint.Attribute], relation: NSLayoutConstraint.Relation = .equal, item item1: UIView, toItem item2: Any?, multiplier: CGFloat = 1.0, constants: [CGFloat]) {
        
        guard attributes.count == constants.count // Equal number of elements
            else { fatalError("Invalid number of constants") }
        
        // Ensure property is false, otherwise constraints won't work.
        if item1.translatesAutoresizingMaskIntoConstraints {
            item1.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // enumerate attributes to access both each element and its index, then apply map to convert each element into a NSLayoutConstraint
        let constraints: [NSLayoutConstraint] = attributes.enumerated().map({ (index, attribute) in
            
            let secondAttribute = (item2 == nil) ? .notAnAttribute : attribute
            
            return NSLayoutConstraint(item: item1, attribute: attribute, relatedBy: relation, toItem: item2, attribute: secondAttribute, multiplier: multiplier, constant: constants[index])
        })
        
        addConstraints(constraints)
    }
    
    /// Wrapper around the addConstraint function to reduce boilerplate code. Use when attributes are different.
    @discardableResult func addConstraint(_ view1: UIView,
                                          attribute firstAttribute: NSLayoutConstraint.Attribute,
                                          relatedBy relation: NSLayoutConstraint.Relation = .equal,
                                          toItem item2: Any?,
                                          attribute secondAttribute: NSLayoutConstraint.Attribute,
                                          multiplier: CGFloat = 1.0,
                                          constant: CGFloat = 0,
                                          priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        // Ensure property is false, otherwise constraints won't work.
        if view1.translatesAutoresizingMaskIntoConstraints {
            view1.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(item: view1, attribute: firstAttribute, relatedBy: relation, toItem: item2, attribute: secondAttribute, multiplier: multiplier, constant: constant)
        
        if let priority = priority {
            constraint.priority = priority
        }
        addConstraint(constraint)
        return constraint
    }
}

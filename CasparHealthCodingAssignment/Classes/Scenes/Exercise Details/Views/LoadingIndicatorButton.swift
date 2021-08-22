//
//  LoadingIndicatorButton.swift
//  CasparHealth
//
//  Created by Gennadii Berezovskii on 16.07.18.
//  Copyright © 2018 GOREHA GmbH. All rights reserved.
//

import UIKit

enum LoadingIndicatorButtonActivityIndicatorPosition {
    case replaceImageView
    case replaceTitleLabel
}

class LoadingIndicatorButton: UIButton {
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    var style: LoadingIndicatorButtonActivityIndicatorPosition = .replaceImageView
    var isLoading = false {
        didSet {
            isEnabled = !isLoading
            if isLoading {
                activityIndicatorView.startAnimating()
            } else {
                activityIndicatorView.stopAnimating()
            }
            if style == .replaceTitleLabel {
                if let titleLabel = titleLabel {
                    setTitleColor(titleLabel.textColor.withAlphaComponent(isLoading ? 0 : 1), for: .normal) 
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        clipsToBounds = true
        semanticContentAttribute = .forceRightToLeft
        titleLabel?.font = UIFont.roboto(weight: .medium)
        addSubview(activityIndicatorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageView = self.imageView, let titleLabel = self.titleLabel else {
            return
        }

        switch self.style {
        case .replaceImageView:
            activityIndicatorView.center = imageView.center
            if isLoading {
                imageView.alpha = 0
            } else {
                imageView.alpha = 1
            }
            
            guard imageView.frame.size != CGSize.zero else {
                self.titleEdgeInsets = .zero
                return
            }

            let imageViewPadding = (frame.height - imageView.frame.height) / 2.0

            let imageViewInitialX = (frame.width - titleLabel.frame.width - imageView.frame.width) / 2.0 + titleLabel.frame.width
            let imageInset = frame.width - imageViewPadding - imageViewInitialX - imageView.frame.width
            let imageEdgeInsets = UIEdgeInsets(top: 0, left: imageInset, bottom: 0, right: -imageInset)
            self.imageEdgeInsets = imageEdgeInsets

            let titleLabelInitialX = (frame.width - titleLabel.frame.width - imageView.frame.width) / 2.0
            let titleLabelNewX = (frame.width - imageView.frame.width - imageViewPadding - titleLabel.frame.width) / 2.0
            let titleLabelInset = titleLabelNewX - titleLabelInitialX
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -titleLabelInset, bottom: 0, right: titleLabelInset)
        case .replaceTitleLabel:
            activityIndicatorView.center = titleLabel.center
        }
    }
    
    public func startLoading() {
        isLoading = true
    }
    
    public func stopLoading() {
        isLoading = false
    }
    
}

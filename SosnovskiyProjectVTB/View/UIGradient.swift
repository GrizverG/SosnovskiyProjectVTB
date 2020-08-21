//
//  UIGradient.swift
//  SosnovskiyProjectVTB
//
//  Created by Gregory Pinetree on 31.07.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit

class UIGradient: UIView {
    
    override func layoutSubviews() {
        
        let gradient = CAGradientLayer()
        gradient.frame.size = bounds.size
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.colors = [UIColor.black.withAlphaComponent(0.9).cgColor,
                           UIColor.black.withAlphaComponent(0.8).cgColor,
                           UIColor.black.withAlphaComponent(0.7).cgColor,
                           UIColor.black.withAlphaComponent(0.4).cgColor,
                            UIColor.black.withAlphaComponent(0.0).cgColor]
        gradient.masksToBounds = true

        alpha = 0.99
        layer.sublayers?.removeAll()
        layer.insertSublayer(gradient, at: 0)
        layer.masksToBounds = true
    }
}

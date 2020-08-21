//
//  UIView+.swift
//  SosnovskiyProjectVTB
//
//  Created by Gregory Pinetree on 01.08.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Pin methods 
    func pin(to superView: UIView, _ const: Int? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : CGFloat(const!)
        NSLayoutConstraint.activate([
        topAnchor.constraint(equalTo: superView.topAnchor, constant: constant),
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -constant),
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -constant),
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant),
        ])
    }
    
    func pinLeft(to superView: UIView, _ const: Int? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : CGFloat(const!)
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant).isActive = true
    }
    
    func pinLeft(to anchor: NSLayoutXAxisAnchor, _ const: Int? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : CGFloat(const!)
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    
    func pinRight(to superView: UIView, _ const: Int? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : CGFloat(const!)
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -constant).isActive = true
    }
    
    func pinRight(to anchor: NSLayoutXAxisAnchor, _ const: Int? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : CGFloat(const!)
        trailingAnchor.constraint(equalTo: anchor, constant: -constant).isActive = true
    }
    
    func pinDown(to superView: UIView, _ const: Int? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : CGFloat(const!)
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -constant).isActive = true
    }
    
    func pinDown(to anchor: NSLayoutYAxisAnchor, _ const: Int? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : CGFloat(const!)
        bottomAnchor.constraint(equalTo: anchor, constant: -constant).isActive = true
    }
    
    func pinUp(to superView: UIView, _ const: Int? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : CGFloat(const!)
        topAnchor.constraint(equalTo: superView.topAnchor, constant: constant).isActive = true
    }
    
    func pinUp(to anchor: NSLayoutYAxisAnchor, _ const: Int? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : CGFloat(const!)
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    
    func resistShrinking(with priority: Int, axis: NSLayoutConstraint.Axis) {
        let priority = Float(priority)
        setContentCompressionResistancePriority(UILayoutPriority(rawValue: priority), for: axis)
    }
    
    func allowGrowing(with priority: Int, axis: NSLayoutConstraint.Axis) {
        let priority = Float(priority)
        setContentHuggingPriority(UILayoutPriority(rawValue: priority), for: axis)
    }
    
    func setHeight(to height: Int) {
        heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }
    
    func setWidth(to width: Int) {
        widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
    }
    
    func pinHeight(to height: NSLayoutDimension, _ const: CGFloat? = 1) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : const!
        heightAnchor.constraint(equalTo: height, multiplier: constant).isActive = true
    }
    
    func pinWidth(to width: NSLayoutDimension, _ const: CGFloat? = 1) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : const!
        widthAnchor.constraint(equalTo: width, multiplier: constant).isActive = true
    }
    
    func pinCenter(to view: UIView, _ const: Int? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : CGFloat(const!)
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }
    
    func pinCenter(to xAnchor: NSLayoutXAxisAnchor, _ const: Int? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : CGFloat(const!)
        centerXAnchor.constraint(equalTo: xAnchor, constant: constant).isActive = true
    }
    
    func pinCenter(to yAnchor: NSLayoutYAxisAnchor, _ const: Int? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let constant = const == nil ? 0 : CGFloat(const!)
        centerYAnchor.constraint(equalTo: yAnchor, constant: constant).isActive = true
    }
    
}


//
//  DragerView.swift
//  SosnovskiyProjectVTB
//
//  Created by Gregory Pinetree on 17.08.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit

final class DragerView: UIView {
    init() {
        super.init(frame: .zero)
        setHeight(to: 25)
        backgroundColor = .dark
        
        let drager = UIView()
        addSubview(drager)
        drager.pinCenter(to: self)
        drager.setHeight(to: 5)
        drager.pinWidth(to: drager.heightAnchor, 10)
        drager.layer.cornerRadius = 2.5
        drager.backgroundColor = .mainColor
        drager.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

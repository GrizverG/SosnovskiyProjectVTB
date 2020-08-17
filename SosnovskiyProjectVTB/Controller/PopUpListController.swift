//
//  PopUpListController.swift
//  SosnovskiyProjectVTB
//
//  Created by Gregory Pinetree on 15.08.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit

final class PopUpListController: UIViewController {
    
    override func viewDidLoad() {
        let menuView = createDragerView()
        menuView.pinLeft(to: view)
        menuView.pinRight(to: view)
        menuView.pinUp(to: view)
    }
    
}

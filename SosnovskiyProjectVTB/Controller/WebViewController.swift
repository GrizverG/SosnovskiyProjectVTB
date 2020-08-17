//
//  WebViewController.swift
//  SosnovskiyProjectVTB
//
//  Created by Gregory Pinetree on 02.08.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        let menuView = createDragerView()
        menuView.pinLeft(to: view)
        menuView.pinRight(to: view)
        menuView.pinUp(to: view)
        
        view.addSubview(webView)
        webView.pinUp(to: menuView.bottomAnchor)
        webView.pinRight(to: view)
        webView.pinDown(to: view)
        webView.pinLeft(to: view)
    }
    
    func loadURL(url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    @objc private func closeWebView() {
        self.dismiss(animated: true, completion: nil)
    }
}

func createDragerView() -> UIView {
    let menuView = UIView()
    menuView.setHeight(to: 25)
    menuView.backgroundColor = .dark
    
    let drager = UIView()
    menuView.addSubview(drager)
    drager.pinCenter(to: menuView)
    drager.setHeight(to: 5)
    drager.pinWidth(to: drager.heightAnchor, 10)
    drager.layer.cornerRadius = 2.5
    drager.backgroundColor = .mainColor
    drager.clipsToBounds = true
    
    return menuView
}

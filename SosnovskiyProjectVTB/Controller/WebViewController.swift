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
        let menuView = DragerView()
        view.addSubview(menuView)
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

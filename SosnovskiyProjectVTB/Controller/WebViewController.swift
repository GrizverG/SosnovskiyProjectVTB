//
//  WebViewController.swift
//  SosnovskiyProjectVTB
//
//  Created by Gregory Pinetree on 02.08.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit
import WebKit

//MARK: - WebViewController

final class WebViewController: UIViewController {
    
    //MARK: - Constants
    
    private let webView = WKWebView()
    
    // MARK: - Properties
    
    private var newsURL: URL?
    
    // MARK: - Life cycle
    
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
    
    // MARK: - Methods
    
    func loadURL(url: URL) {
        
        newsURL = url
        webView.load(URLRequest(url: url))
    }
    
    // MARK: - Actions
    
    @objc private func closeWebView() {
        
        self.dismiss(animated: true, completion: nil)
    }
}

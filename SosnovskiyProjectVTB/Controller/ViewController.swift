//
//  ViewController.swift
//  SosnovskiyProjectVTB
//
//  Created by Gregory Pinetree on 29.06.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var articleManager: ArticleManager!
    var NewsTable = UITableView()
    var MenuBar = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleManager = ArticleManager(viewController: self)
        setupMenuBar()
        setupTableView()
        fetchData()
    }

    func fetchData() {
        articleManager.updateNewsList(url: getURL(index: 1, rubric: 4))
    }
    
    func setupMenuBar() {
        view.addSubview(MenuBar)
        MenuBar.backgroundColor = .cyan
        MenuBar.translatesAutoresizingMaskIntoConstraints = false
        MenuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        MenuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        MenuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        MenuBar.heightAnchor.constraint(equalToConstant: CGFloat(70)).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(NewsTable)
        NewsTable.delegate = self
        NewsTable.dataSource = self
        NewsTable.rowHeight = 240
        NewsTable.allowsMultipleSelection = false
        NewsTable.register(ArticleCell.self, forCellReuseIdentifier: Cells.newsCell)
        NewsTable.translatesAutoresizingMaskIntoConstraints = false
        NewsTable.topAnchor.constraint(equalTo: MenuBar.bottomAnchor).isActive = true
        NewsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        NewsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        NewsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    struct Cells {
        static let newsCell = "ArticleCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleManager.ArticleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: Cells.newsCell) as! ArticleCell
        newsCell.set(article: articleManager.ArticleArray[indexPath.row])
        return newsCell
    }
    
    func refreshNewsTable() {
        NewsTable.reloadData()
    }
}


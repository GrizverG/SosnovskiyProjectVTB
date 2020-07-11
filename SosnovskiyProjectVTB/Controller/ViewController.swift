//
//  ViewController.swift
//  SosnovskiyProjectVTB
//
//  Created by Gregory Pinetree on 29.06.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit
final class ViewController: UIViewController {
    
    // MARK: - Properties
    private var articleManager: ArticleManager!
    private var NewsTable = UITableView()
    private weak var CollectionView: UICollectionView!
    private var MenuBar = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupArticleManager()
        setupMenuBar()
        setupTableView()
        setupCollectionView()
        fetchData()
    }
    
    func fetchData() {
        articleManager.updateNewsList(url: getURL(index: 1, rubric: 4))
    }
    
    // MARK: - Article Manager
    func setupArticleManager() {
        articleManager = ArticleManager()
        articleManager.delegate = self
    }
    
    // MARK: - Menu bar setup
    func setupMenuBar() {
        view.addSubview(MenuBar)
        MenuBar.backgroundColor = .cyan
        MenuBar.translatesAutoresizingMaskIntoConstraints = false
        MenuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        MenuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        MenuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        MenuBar.heightAnchor.constraint(equalToConstant: CGFloat(70)).isActive = true
    }
    
    // MARK: - CollectionView setup
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = false
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: Cells.newsCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: MenuBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.CollectionView = collectionView
    }
    
    // MARK: - TableView setup
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

// MARK: - CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    struct Cells {
        static let newsCell = "ArticleCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleManager.ArticleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.newsCell, for: indexPath) as! NewsCell
        newsCell.set(article: articleManager.ArticleArray[indexPath.row])
        return newsCell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 280)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleManager.ArticleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: Cells.newsCell) as! ArticleCell
        newsCell.set(article: articleManager.ArticleArray[indexPath.row])
        return newsCell
    }
}

// MARK: - RefrshDelegate
extension ViewController: RefreshDelegate {
    func refresh() {
        DispatchQueue.main.sync {
            refreshNewsTable()
        }
    }
    
    func refreshNewsTable() {
        NewsTable.reloadData()
        CollectionView.reloadData()
    }
}


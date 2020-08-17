//
//  ViewController.swift
//  SosnovskiyProjectVTB
//
//  Created by Gregory Pinetree on 29.06.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit
final class ViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let menuViewSpacing = 1
        static let menuViewHeight = 700
        static let menuViewBorderWidth: CGFloat = 4
        static let menuViewCornerRadius: CGFloat = 20
        
        static let sideSpacing = 15
        static let bottomSpacing = 15
        static let buttonHeight = 35
        
        static let collectionViewAbove = 40
    }
    
    // MARK: - Properties
    private var articleManager: ArticleManager!
    private var newsCollectionView: UICollectionView!
    private var menuView = UIView()
    private var menuViewConstraint: NSLayoutConstraint?
    private var refreshControl = UIRefreshControl()
    private var settingsButton = UIButton(type: .system)
    private var menuButton = UIButton(type: .system)
    private var buttonStackView = UIStackView()
    private var menuStackView = UIStackView()
    private var newView = UIView()
    private var constraint: NSLayoutConstraint?
    
    private var menuHeight = 0
    
    private var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 280)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .dark
        
        setupArticleManager()
        setupMenuBar()
        setupButtonStackView()
        setupMenuStackView()
        setupCollectionView()
        fetchData()
    }
    
    private func fetchData() {
        articleManager.updateNewsList(url: getURL(index: 1, rubric: 4))
    }
    
    // MARK: - Article Manager
    private func setupArticleManager() {
        articleManager = ArticleManager()
        articleManager.delegate = self
    }
    
    // MARK: - Menu bar setup
    private func setupMenuBar() {
        view.addSubview(menuView)
        menuView.backgroundColor = .dark
        menuView.layer.borderWidth = Constants.menuViewBorderWidth
        menuView.layer.borderColor = UIColor.energo.cgColor
        constraint = menuView.bottomAnchor.constraint(equalTo: view.topAnchor)
        constraint?.isActive = true
        menuView.pinLeft(to: view)
        menuView.pinRight(to: view)
        menuView.setHeight(to: Constants.menuViewHeight)
        menuView.layer.cornerRadius = Constants.menuViewCornerRadius
        menuView.layer.masksToBounds = true
        
        view.addSubview(newView)
        newView.backgroundColor = .energo
        newView.layer.borderWidth = 6
        newView.layer.borderColor = UIColor.mainColor.cgColor
        newView.pinDown(to: view, -10)
        newView.pinLeft(to: view, -10)
        newView.pinRight(to: view, -10)
        newView.setHeight(to: 80)
    }
    
    private func setupButtonStackView() {
        newView.addSubview(buttonStackView)
        buttonStackView.pinRight(to: newView, Constants.sideSpacing + 10)
        buttonStackView.pinLeft(to: newView, Constants.sideSpacing + 10)
        buttonStackView.pinDown(to: newView, Constants.bottomSpacing + 10)
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .equalSpacing
        buttonStackView.tintColor = .mainColor
        
        settingsButton = createMenuButton(#selector(settingsButtonAction), "settings", .mainColor)
        addToButtonStackView(view: settingsButton)
        
        menuButton = createMenuButton(#selector(menuButtonAction), "menu", .mainColor)
        addToButtonStackView(view: menuButton)
    }
    
    private func setupMenuStackView() {
        menuView.addSubview(menuStackView)
        menuStackView.pinUp(to: menuView, 120)
        menuStackView.pinLeft(to: menuView, Constants.sideSpacing)
        menuStackView.pinRight(to: menuView, Constants.sideSpacing)
        menuStackView.pinDown(to: menuView, 90)
        menuStackView.axis = .vertical
        menuStackView.distribution = .equalSpacing
        menuStackView.tintColor = .mainColor
        
        addToMenuStackView(view: createMenuButton(#selector(settingsButtonAction), "settings", .mainColor))
    }
    
    private func createMenuButton(_ action: Selector, _ imageName: String, _ tintColor: UIColor) -> UIButton {
        let button = UIButton()
        
        button.setHeight(to: Constants.buttonHeight)
        button.pinWidth(to: button.heightAnchor, 1)
        button.addTarget(self, action: action, for: .touchUpInside)
        let origImage = UIImage(named: imageName)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .mainColor
        
        return button
    }
    
     //  MARK: - Add to menu stack view
    private func addToMenuStackView(view: UIView) {
        menuStackView.addArrangedSubview(view)
        
        view.pinLeft(to: menuStackView)
        view.pinRight(to: menuStackView)
    }
    
     //  MARK: - Add to stack view
    private func addToButtonStackView(view: UIView) {
        buttonStackView.addArrangedSubview(view)
        
        view.pinUp(to: buttonStackView)
        view.pinDown(to: buttonStackView)
    }
    
    // MARK: - CollectionView setup
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: #selector(refreshNewsPage), for: .valueChanged)
        refreshControl.tintColor = .mainColor
        collectionView.addSubview(refreshControl)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .dark
        collectionView.allowsMultipleSelection = false
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: Cells.newsCell)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(UICollectionViewCell.self)")
        
        if #available(iOS 11.0, *) {
            collectionView.pinUp(to: view.safeAreaLayoutGuide.topAnchor)
        } else {
            collectionView.pinUp(to: view)
        }
        collectionView.pinDown(to: newView.topAnchor)
        collectionView.pinLeft(to: view)
        collectionView.pinRight(to: view)

        self.newsCollectionView = collectionView
        view.bringSubviewToFront(menuView)
        view.bringSubviewToFront(newView)
    }
    
    @objc private func settingsButtonAction() {
        UIView.animate(withDuration: 0.3, animations: {
            self.settingsButton.transform = self.settingsButton.transform.rotated(by: CGFloat.pi)
        }, completion: {(finished: Bool) in
            
        })
    }
    
    @objc private func menuButtonAction() {
        
    }
    
    @objc private func refreshNewsPage() {
        if !articleManager.isLoading {
            articleManager.isLoading = true
            fetchFreshNews(1, articleManager.rubric)
        }
    }
    
    private func fetchFreshNews(_ page: Int, _ rubric: Rubrics) {
        articleManager.pageIndex = page
        articleManager.rubric = rubric
        let url = getURL(index: page, rubric: rubric.rawValue)
        articleManager.updateNewsList(url: url)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    struct Cells {
        static let newsCell = "ArticleCell"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return articleManager.articleArray.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.newsCell, for: indexPath) as! NewsCell
            newsCell.set(article: articleManager.articleArray[indexPath.row])
            return newsCell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(UICollectionViewCell.self)", for: indexPath)
            cell.setHeight(to: 50)
            let indicator = UIActivityIndicatorView(style: .whiteLarge)
            indicator.color = .mainColor
            cell.addSubview(indicator)
            indicator.pinCenter(to: cell.contentView)
            indicator.startAnimating()
            cell.backgroundColor = .clear
            return cell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "\(UICollectionViewCell.self)", for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webVC = WebViewController()
        webVC.loadURL(url: articleManager.articleArray[indexPath.row].seldonURL)
        self.present(webVC, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height - 800 {
            if !articleManager.isLoading {
                articleManager.updateNewsList()
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 280)
        case 1:
            return CGSize(width: collectionView.bounds.width, height: 50)
        default:
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 1:
            return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        default:
            return UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        }
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

// MARK: - RefrshDelegate
extension ViewController: RefreshDelegate {
    func refresh() {
        DispatchQueue.main.sync {
            refreshNewsCollection()
            refreshControl.endRefreshing()
            articleManager.isLoading = false
        }
    }
    
    func refreshNewsCollection() {
        newsCollectionView.reloadData()
    }
}


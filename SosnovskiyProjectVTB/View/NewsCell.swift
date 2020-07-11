//
//  NewsCell.swift
//  SosnovskiyProjectVTB
//
//  Created by Gregory Pinetree on 11.07.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit
import Foundation

final class NewsCell: UICollectionViewCell {
    
    private weak var newsImageView: UIImageView!
    private weak var newsHeaderLabel: UILabel!
    private weak var newsDescriptionLabel: UILabel!
    
    static var identifier: String = "ArticleCell"

    struct Colors {
        static let backgroundFadingColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 0.6)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupImage()
        setupHeader()
        setupDescription()
        
        self.reset()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(article: Article) {
        newsImageView.image = article.image
        newsHeaderLabel.text = article.header
        newsDescriptionLabel.text = article.announce
    }
    
    func setupImage() {
        let newsImageView = UIImageView()
        addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.layer.cornerRadius = 15
        newsImageView.clipsToBounds = true
        newsImageView.contentMode = .scaleToFill
        newsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(5)).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(-5)).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(5)).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(-5)).isActive = true
        self.newsImageView = newsImageView
    }
    
    func setupHeader() {
        let newsHeaderLabel = UILabel()
        addSubview(newsHeaderLabel)
        newsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        newsHeaderLabel.numberOfLines = 0
        newsHeaderLabel.font = UIFont.boldSystemFont(ofSize: 16)
        newsHeaderLabel.textColor = .white
        newsHeaderLabel.backgroundColor = Colors.backgroundFadingColor
        newsHeaderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 130).isActive = true
        newsHeaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        newsHeaderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        self.newsHeaderLabel = newsHeaderLabel
    }
    
    func setupDescription() {
        let newsDescriptionLabel = UILabel()
        addSubview(newsDescriptionLabel)
        newsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        newsDescriptionLabel.numberOfLines = 0
        newsDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        newsDescriptionLabel.textColor = .white
        newsDescriptionLabel.backgroundColor = Colors.backgroundFadingColor
        newsDescriptionLabel.topAnchor.constraint(equalTo: newsHeaderLabel.bottomAnchor).isActive = true
        newsDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        newsDescriptionLabel.leadingAnchor .constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        newsDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        self.newsDescriptionLabel = newsDescriptionLabel
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }

    func reset() {
        self.newsHeaderLabel.textAlignment = .center
        self.newsDescriptionLabel.textAlignment = .center
        self.newsImageView.image = nil
    }
}

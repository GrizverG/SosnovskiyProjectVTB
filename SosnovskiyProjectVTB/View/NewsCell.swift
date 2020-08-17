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
    
    // MARK: - Constants
    private var newsImageView = UIImageView()
    private let newsHeaderLabel = UILabel()
    private let descriptionLabel = UILabel()
    private var gradientView = UIGradient()
    private var stackView = UIStackView()
    private var infoView = UIView()
    
    static let identifier: String = "ArticleCell"
    
    private enum Constants {
        static let headerFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        static let descriptionFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    }

    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    // MARK: - NewsCell init
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .dark
        loadCell()

        self.reset()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadCell() {
        newsImageView.removeFromSuperview()
        infoView.removeFromSuperview()
        gradientView.removeFromSuperview()
        stackView.removeFromSuperview()
        newsHeaderLabel.removeFromSuperview()
        descriptionLabel.removeFromSuperview()
        setupImage()
        setupGradient()
        setupStackView()
        setupLabel(label: newsHeaderLabel, font: Constants.headerFont, .mainColor)
        setupLabel(label: descriptionLabel, font: Constants.descriptionFont, .white)
    }
    
    // Mark setup cell
    func set(article: Article) {
        newsImageView.image = article.image
        newsHeaderLabel.text = article.header
        descriptionLabel.text = article.announce
    }
    
    // MARK: - Setup newsImageView
    private func setupImage() {
        newsImageView = UIImageView()
        let imageView = newsImageView
        contentView.addSubview(imageView)
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 400).isActive = true
        imageView.resistShrinking(with: 2000, axis: .vertical)
        
        imageView.pin(to: contentView, 5)
    }
    
    // MARK: - Setup gradient
    private func setupGradient() {
        infoView = UIView()
        newsImageView.addSubview(infoView)
        infoView.pinLeft(to: newsImageView)
        infoView.pinRight(to: newsImageView)
        infoView.pinDown(to: newsImageView)
        infoView.resistShrinking(with: 1000, axis: .vertical)
        gradientView = UIGradient()
        infoView.addSubview(gradientView)
        gradientView.pin(to: infoView)
    }
    
    
    //MARK: - Setup stack view
    private func setupStackView() {
        stackView = UIStackView()
        infoView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        
        stackView.pinDown(to: infoView, 5)
        stackView.pinLeft(to: infoView, 5)
        stackView.pinRight(to: infoView, 5)
        stackView.pinHeight(to: infoView.heightAnchor, 0.45)
        stackView.resistShrinking(with: 900, axis: .vertical)
    }
    
     //  MARK: - Add to stack view
    private func addToStackView(view: UIView) {
        stackView.addArrangedSubview(view)
        
        view.pinLeft(to: stackView)
        view.pinRight(to: stackView)
        view.resistShrinking(with: 1000, axis: .vertical)
    }
    
    // MARK: - Setup label
    private func setupLabel(label: UILabel, font: UIFont, _ color: UIColor) {
        label.font = font
        label.numberOfLines = 0
        label.textColor = color
        label.textAlignment = .left

        addToStackView(view: label)
    }

    // MARK: - Prepare for use
    override func prepareForReuse() {
        super.prepareForReuse()
        loadCell()
        self.reset()
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }

    // MARK: - Reset
    func reset() {
        self.newsHeaderLabel.textAlignment = .left
        self.descriptionLabel.textAlignment = .left
        self.newsImageView.image = nil
    }
}

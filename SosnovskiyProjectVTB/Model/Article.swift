//
//  Article.swift
//  SosnovskiyProjectVTB
//
//  Created by Gregory Pinetree on 30.06.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit
import Foundation

fileprivate var requestID = ""

// MARK: - ArticleList

public struct ArticleList: Decodable {
    
    // MARK: - Properties
    
    var items: [Article]
    var requestId: String
    
    // MARK: - Coding keys

    enum CodingKeys: String, CodingKey {
        case items = "news"
        case requestId
    }
    
    // MARK: - Article List init
    
    public init (from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.requestId = try container.decode(String.self, forKey: .requestId)
        self.items = try container.decode([Article].self, forKey: .items)
        
        requestID = self.requestId
    }
}

// MARK: - Article

struct Article: Decodable {
    
    // MARK: - Properties
    
    var newsID: Int = 0
    var timeToRead: String? = ""
    var sourceName: String? = ""
    var imageURL: ImageURL = ImageURL()
    var header: String? = ""
    var publicationDate: String? = ""
    var announce: String? = ""
    var image: UIImage = UIImage(named: "backupImage")!
    
    var seldonURL: URL {
        let url = URL(string: "https://news.myseldon.com/ru/news/index/\(newsID)?requestId=\(requestID)")
        return url!
    }

    enum imageKey: String, CodingKey {
        case url
    }
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case newsId
        case header = "title"
        case timeToRead = "timeOfReading"
        case sourceName
        case publicationDate = "date"
        case announce
        case img
    }
    
    // MARK: - Article init
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let newsID = try container.decode(Int.self, forKey: .newsId)
        let header = try container.decode(String?.self, forKey: .header)
        let timeToRead = try container.decode(String?.self, forKey: .timeToRead)
        let publicationDate = try container.decode(String?.self, forKey: .publicationDate)
        let announce = try container.decode(String?.self, forKey: .announce)
        let sourceName = try container.decode(String?.self, forKey: .sourceName)
        
        self.newsID = newsID
        self.header = prepareHeader(header ?? "")
        self.timeToRead = timeToRead
        self.publicationDate = preparePublicationDate(publicationDate ?? "")
        self.announce = announce
        self.imageURL = try container.decode(ImageURL.self, forKey: .img)
        self.sourceName = sourceName
        
        if let image = loadImage() {
            self.image = image
        }
    }
    
    private func prepareHeader(_ header: String) -> String {
        
        let title = header.replacingOccurrences(of: "<b>", with: "")
        return title.replacingOccurrences(of: "</b>", with: "")
    }
    
    // TODO: - Change language of the date
    private func preparePublicationDate(_ date: String) -> String {
        
        let dateFormatter = DateFormatter()
        let preparedDate = date.split(separator: ".")
        let date = preparedDate[0].description
        
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from:date)?.description ?? ""
    }
    
    private func loadImage() -> UIImage? {
        
        if let data = try? Data(contentsOf: imageURL.url) {
            if let receivedImage = UIImage(data: data) {
                return receivedImage
            }
        }
        return nil
    }
}

// MARK: - ImageURL

struct ImageURL: Codable {
    var url: URL
    
    init() {
        self.url = URL(fileURLWithPath: "")
    }
}

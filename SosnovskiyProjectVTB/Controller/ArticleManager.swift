//
//  ArticleManager.swift
//  SosnovskiyProjectVTB
//
//  Created by Gregory Pinetree on 02.07.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import Foundation


protocol RefreshDelegate: class {
    func refresh()
}

// #MARK: Get URL
public func getURL(index: Int, rubric: Int) -> URL {
    return URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(index)")!
}

public func getURL(task: String) -> URL{
    return URL(string: "https://news.myseldon.com/news/search?text=\(task)")!
}

// MARK: - ArticleManager
final public class ArticleManager {
    
    //
    // MARK: - Constants
    //
    let defaultSession = URLSession(configuration: .default)
    
    //
    // MARK: - Variables And Properties
    //
    var dataTask: URLSessionDataTask?
    private var articleArray: [Article] = []
    var ArticleArray: [Article] {
        get {
            return articleArray
        }
        set(articles) {
            articleArray = articles
            delegate?.refresh()
        }
    }
    
    // MARK:- Delegate
    weak var delegate: RefreshDelegate?
    
    func updateNewsList(url: URL) {
        
        fetchNews(url: url) { [weak self] results in
            if let results = results {
                self?.ArticleArray = results
            }
        }
    }
    
    //
    // MARK: - fetchNews
    //
    private func fetchNews(url: URL, completion: @escaping ([Article]?) -> Void) {
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                self?.loadNews(data)
            }
        }
        dataTask?.resume()
    }
    
    //
    // MARK: - loadNews
    //
    private func loadNews(_ data: Data) {
        articleArray.removeAll()
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let articleList: ArticleList = try decoder.decode(ArticleList.self, from: data)
            ArticleArray = articleList.items
        } catch {
            
        }
    }
}

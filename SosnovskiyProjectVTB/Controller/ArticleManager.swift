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

enum Rubrics: Int {
    case main = 4
}

// MARK: - Get URL

func getURL(index: Int, rubric: Int) -> URL {
    
    return URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(index)")!
}

func getURL(task: String) -> URL{
    
    return URL(string: "https://news.myseldon.com/news/search?text=\(task)")!
}



// MARK: - ArticleManager

final public class ArticleManager {
    
    // MARK: - Constants
    
    let defaultSession = URLSession(configuration: .default)
    
    // MARK: - Properties
    
    var dataTask: URLSessionDataTask?
    var isLoading = false
    var pageIndex = 1
    var rubric: Rubrics = .main
    private var _articleArray: [Article] = []
    var articleArray: [Article] {
        get {
            return _articleArray
        }
        set(articles) {
            _articleArray = articles
            delegate?.refresh()
            isLoading = false
            pageIndex += 1
            print(pageIndex)
        }
    }
    
    // MARK: - Delegate
    
    weak var delegate: RefreshDelegate?
    
    // MARK: - Update news
    
    func updateNewsList() {
        
        isLoading = true
        let url =  getURL()
        fetchNews(url: url)
    }
    
    func updateNewsList(url: URL) {
        
        fetchNews(url: url, false)
    }
    
    // MARK: - Get URL
    private func getURL() -> URL {
        
        return URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric.rawValue)&pageSize=8&pageIndex=\(pageIndex)")!
    }
    
    // MARK: - Fetch news
    private func fetchNews(url: URL, _ isAdding: Bool = true) {
        
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
                self?.loadNews(data, isAdding)
            }
        }
        dataTask?.resume()
    }
    
    // MARK: - Load news
    private func loadNews(_ data: Data, _ isAdding: Bool = true) {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let articleList: ArticleList = try decoder.decode(ArticleList.self, from: data)
            if !isAdding {
                _articleArray = []
            }
            articleArray.append(contentsOf: articleList.items)
        } catch {
            print(error)
        }
    }
}

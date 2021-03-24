//
//  NetworkManager.swift
//  News
//
//  Created by Andrew Trach on 23.03.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    struct NewsError: Error {
        var text: String
    }
    
    func getNews(search: String, sortBy: String, page: Int,
                   success: @escaping ([News]) -> Void,
                   failure: @escaping (NewsError) -> () ) {
     
        Alamofire.request("https://newsapi.org/v2/everything?q=\(search)&sortBy=\(sortBy)&pePage=20&page=\(page)&apiKey=54c2cf147d724ce9817c323ca8cba546").responseJSON { response in
                    if let error = self.observeError(with: response.value) {
                        failure(error)
                    } else if let jsonDict = response.result.value as? [String: Any] {
            if let articlesDictArray = jsonDict["articles"] as? [[String: Any]] {
                        var newsArray = [News]()
                        for dict in articlesDictArray {
                            if let news = News.init(with: dict) {
                                newsArray.append(news)
                            }
                        }
                        success(newsArray)
                    } else {
                        failure(NewsError.init(text: "Some error"))
                    }
                   }
        }
    }
    
    func observeError(with response: Any?) -> NewsError? {
        if let dict = response as? [String: Any],
           let error = dict["error"] as? String {
            return NewsError(text: error)
        }
        return nil
    }
}

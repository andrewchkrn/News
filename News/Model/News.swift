//
//  News.swift
//  News
//
//  Created by Andrew Trach on 23.03.2021.
//

import Foundation

struct News {
    let name: String
    var authorString = ""
    let title: String
    let description: String
    let urlToImage: URL
    let url: URL
    let publishedAt: String
    
    init?(with dict: [String: Any]) {
        guard let sourceDict = dict["source"] as? [String: Any],
            let name = sourceDict["name"] as? String,
            let title = dict["title"] as? String,
            let description = dict["description"] as? String,
            let urlString = dict["url"] as? String,
            let url = URL.init(string: urlString),
            let urlToImageString = dict["urlToImage"] as? String,
            let urlToImage = URL.init(string: urlToImageString),
            let publishedAt = dict["publishedAt"] as? String else {
                return nil
        }
        
        self.name = name
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
        self.url = url
        self.publishedAt = publishedAt
        
        if let authorString = dict["author"] as? String {
            self.authorString = authorString
        }
    }
}

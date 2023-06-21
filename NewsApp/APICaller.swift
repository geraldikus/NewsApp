//
//  APICaller.swift
//  NewsApp
//
//  Created by Anton on 20.06.23.
//

import UIKit

final class APICaller {
    
    static let shared = APICaller()
    
    struct Constant {
        static let topHeadLinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=33109c340d87428a967017d7b4e8451a")
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constant.topHeadLinesURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
            task.resume()
    }
}

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String // Тут должна быть Дата, но с ней выдает ошибку. Мб будут проблемы позже
}

struct Source: Codable {
    let name: String
}

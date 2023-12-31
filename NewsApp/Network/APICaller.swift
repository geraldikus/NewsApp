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
        static let searchURLString =  "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=33109c340d87428a967017d7b4e8451a&q="
        static let topSportLinesURL = URL(string: "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=33109c340d87428a967017d7b4e8451a&q=sport")
        static let topBusinessLinesURL = URL(string: "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=33109c340d87428a967017d7b4e8451a&q=business")
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
    
    
    public func getSportStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constant.topSportLinesURL else { return }
        
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
    
    public func getBusinessStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constant.topBusinessLinesURL else { return }
        
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
    
    public func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                
        let urlString = Constant.searchURLString + query
                
        guard let url = URL(string: urlString) else { return }
        
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


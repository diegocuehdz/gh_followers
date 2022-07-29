//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 07/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

class NetworkManager
{
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users"
    let cache = NSCache<NSString, UIImage>()

    private init() { }
    
    func service_GetFollowerList(for username: String, page: Int, handler: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "/\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            handler(.failure(.errorInvalidUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                handler(.failure(.errorUnableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                handler(.failure(.errorInvalidResponse))
                return
            }
            
            guard let data = data else {
                handler(.failure(.errorInvalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                handler(.success(followers))
                return
            } catch {
                handler(.failure(.errorParsingData))
                return
            }
        }

        task.resume()
    }
    
    func service_GetUser(for username: String, handler: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseURL + "/\(username)"
        guard let url = URL(string: endpoint) else {
            handler(.failure(.errorInvalidUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                handler(.failure(.errorUnableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                handler(.failure(.errorInvalidResponse))
                return
            }
            
            guard let data = data else {
                handler(.failure(.errorInvalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let userReturn = try decoder.decode(User.self, from: data)
                handler(.success(userReturn))
                return
            } catch {
                handler(.failure(.errorParsingData))
                return
            }
        }

        task.resume()
    }

}


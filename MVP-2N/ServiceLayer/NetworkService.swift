//
//  NetworkService.swift
//  MVP-2N
//
//  Created by Denis Medvedev on 05/10/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getComments(complition: @escaping (Result<[Comment]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getComments(complition: @escaping (Result<[Comment]?, Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/comments"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            do {
                let obj = try? JSONDecoder().decode([Comment].self, from: data!)
                complition(.success(obj))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}

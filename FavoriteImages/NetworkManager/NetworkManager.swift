//
//  NetworkManager.swift
//  FavoriteImages
//
//  Created by Nikita Batrakov on 08.05.2023.
//

import UIKit

enum NetworkError: String, Error {
    case invalidURL = "Invalid URL"
    case invalidData = "Invalid Data"
}

enum RequestURL: String {
    case dummy = "https://dummyimage.com/300x300&text="
}

final class NetworkManager {
    
    static func fetch(_ imageText: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: RequestURL.dummy.rawValue + imageText) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.invalidData))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
    
}

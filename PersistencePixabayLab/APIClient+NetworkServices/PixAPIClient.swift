//
//  PixAPIClient.swift
//  PersistencePixabayLab
//
//  Created by Kelby Mittan on 1/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation
import NetworkHelper

struct PixAPIClient {
    
    static func getPix(for search: String, completion: @escaping (Result<[PixImage], AppError>) -> ()) {
        
        let pixEndpointURL = "https://pixabay.com/api/?key=\(APIKey.key)&q=\(search)&image_type=photo"
        
        guard let url = URL(string: pixEndpointURL) else {
            completion(.failure(.badURL(pixEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let pixSearch = try JSONDecoder().decode(PixSearch.self, from: data)
                    let pixHits = pixSearch.hits
                    completion(.success(pixHits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}

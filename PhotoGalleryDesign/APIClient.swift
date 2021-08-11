//
//  APIClient.swift
//  PhotoGalleryDesign
//
//  Created by Nazario Mariano on 8/11/21.
//

import Foundation

let baseURL = "https://api.unsplash.com"

enum APIError: Error {
    case failed
}

class APIClient {
    func fetch(resource: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession(configuration: .default)
        let url = URL(string: "\(baseURL)/\(resource)?client_id=\(APIKey)")
        
        guard let url = url else {
            completionHandler(nil, nil, APIError.failed)
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            completionHandler(data, response, error )
        }
        
        task.resume()
    }
}

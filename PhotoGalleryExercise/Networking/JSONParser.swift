//
//  JSONParser.swift
//  PhotoGalleryDesign
//
//  Created by Nazario Mariano on 8/11/21.
//

import Foundation

enum ParserError: Error {
    case failed(String)
}

struct JSONParser {
    // Input Data
    // Expected output -> either and error or valid model
    
    func parse<Model: Codable>(data: Data, completionHandler: @escaping ([Model]?, Error?) -> Void) {
        do {
            let jsonDecoder = JSONDecoder()
            
            let models = try jsonDecoder.decode([Model].self, from: data)
            
            DispatchQueue.main.async {
                completionHandler(models, nil)
            }
        } catch {
            completionHandler(nil, ParserError.failed(error.localizedDescription))
        }
    }
}

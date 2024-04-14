//
//  Network.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 13/04/24.
//

import Foundation

enum NetwrokError: Error {
    case urlError
    case parsingError
}

public class Network {
    
    static func getPoductsFromSerice(skip: Int, limit: Int, completionHandler: @escaping(_ _result: Result<ProductListResponse, NetwrokError>) -> Void) {
        let urlString = Constant.shared.productURLString + "?limit=\(limit)&skip=\(skip)"
        print(urlString)
        guard let url = URL(string: urlString) else {
            completionHandler(Result.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil,
               let data = dataResponse,
               let resultData = try?JSONDecoder().decode(ProductListResponse.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                print(error.debugDescription)
                completionHandler(.failure(.parsingError))
            }
        }.resume()
    }
}

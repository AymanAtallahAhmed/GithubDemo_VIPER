//
//  NetworkManager.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/25/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire

class NetworkManager {
    private let baseURL = "https://api.github.com"
        
    func getObjects<T: Codable>(ofType type: T.Type,
                                endpoint: String,
                                method: HTTPMethod = .get,
                                completionHandler: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: baseURL + endpoint) else { return }
        
        AF.request(url, method: method, encoding: URLEncoding.queryString)
            .responseJSON { (response) in
            print(response)
            if response.error == nil{
                do{
                    guard let data = response.data else { return }
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let result = try decoder.decode(T.self, from: data)
                    completionHandler(.success(result))
                    
                    print(result)
                }catch let error {
                    print("failed to decode json -----> \(error)")
                    completionHandler(.failure(error))
                }
            } else {
                print("Something Went Wrong")
                completionHandler(.failure(response.error!))
            }
        }
    }
}

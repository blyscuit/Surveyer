//
//  TokenService.swift
//  Tokener
//
//  Created by Pisit W on 12/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit
import Alamofire

protocol TokenServiceProtocol : class {
    func postLogin(username: String, password: String, completionHandler: @escaping (TokenModel?, Error?) -> Void) -> Alamofire.Request
}

final class TokenService : TokenServiceProtocol {
    
    static let shared = TokenService()
    
    let endpoint = baseURL
    
    func postLogin(username: String, password: String, completionHandler: @escaping (TokenModel?, Error?) -> Void) -> Alamofire.Request {
        let url = endpoint + "oauth/token"
        let params = ["grant_type": "password", "username": username, "password": password]

        return AF.request(url, method: .post, parameters: params).responseJSON(completionHandler: { response in
            
            if let data = response.value as? [String : Any] {
                
                print(data)

                if let tokenModel = TokenModel(JSON: data), tokenModel.accessToken != nil {
                    completionHandler(tokenModel, nil)
                } else if let error = NetworkError(JSON: data) {
                    completionHandler(nil, error)
                }
                
            } else {
                completionHandler(nil, NetworkError.init(description: "Error", code: response.response?.statusCode))
            }
        })
    }

}

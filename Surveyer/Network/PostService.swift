//
//  PostService.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import Foundation
import Alamofire

let baseURL = "https://nimble-survey-api.herokuapp.com/"

class PostService {
    
    static func getSurveys(page: Int = 0, perPage: Int = 10, completionHandler: @escaping ([HotelModel]?, Error?) -> Void) -> Alamofire.Request {
        let url = baseURL + "surveys.json?page=\(page)&per_page=\(perPage)"
        let params = ["access_token": UserManager.getAccessToken()]

        return Alamofire.request(url, method: .get, parameters: params).responseJSON(completionHandler: { response in
            
            if let data = response.result.value {
                
                guard let jsonResponse = data as? NSArray else {
                completionHandler(nil, NetworkError.init(description: "Parsing error", code: response.response?.statusCode))
                    return
                }
                print(jsonResponse)
                let dictionaryItems = jsonResponse as? [[String: Any]]
                
                guard let arrayItems = dictionaryItems else {
                    completionHandler(nil, NetworkError.init(description: "Parsing error", code: response.response?.statusCode))
                    return
                }
                
                let listPosts = arrayItems.map({ (dic) -> HotelModel in
                    return HotelModel(JSON: dic)!
                })
                
                completionHandler(listPosts, nil)
                
            } else {
                completionHandler(nil, NetworkError.init(description: "Error", code: response.response?.statusCode))
                
            }
        })
    }
    

        
    static func postLogin(username: String, password: String, completionHandler: @escaping (TokenModel?, Error?) -> Void) -> Alamofire.Request {
//        let url = "https://jsonplaceholder.typicode.com/posts"
        let url = baseURL + "oauth/token"
        let params = ["grant_type": "password", "username": username, "password": password]

        return Alamofire.request(url, method: .post, parameters: params).responseJSON(completionHandler: { response in
            
            if let data = response.result.value as? [String : Any] {
                
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

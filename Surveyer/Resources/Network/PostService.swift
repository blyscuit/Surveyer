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
    
    static func getSurveys(completionHandler: @escaping ([HotelModel]?, Error?) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/posts?userId=1"
//        let url = baseURL + "/surveys.json?page=1&per_page=1"

        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
            
            if let data = response.result.value {
                
                let jsonResponse = data as! NSArray
                print(jsonResponse)
                let dictionaryItems = jsonResponse as? [[String: Any]]
                
                guard let arrayItems = dictionaryItems else {
                    completionHandler(nil, NetworkError.init(description: "Parsing error", code: response.response?.statusCode))
                    return
                }
                
                let listPosts = arrayItems.map({ (dic) -> HotelModel in
                    return HotelModel(JSON: dic)!
                })
                
                //let size = jsonResponse["size"] as? Int
                completionHandler(listPosts, nil)
                
            } else {
                completionHandler(nil, NetworkError.init(description: "Error", code: response.response?.statusCode))
                
            }
        }
        )
    }
}

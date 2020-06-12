//
//  SurveyService.swift
//  Surveyer
//
//  Created by Pisit W on 12/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit
import Alamofire

protocol SurveyServiceProtocol : class {
    func getSurveys(page: Int, perPage: Int, completionHandler: @escaping ([HotelModel]?, Error?) -> Void) -> Alamofire.Request
}

final class SurveyService : SurveyServiceProtocol {
    
    static let shared = SurveyService()
    
    let endpoint = baseURL
    
    func getSurveys(page: Int = 0, perPage: Int = 10, completionHandler: @escaping ([HotelModel]?, Error?) -> Void) -> Request {
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

}

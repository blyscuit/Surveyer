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
    func getSurveys(page: Int, perPage: Int, completionHandler: @escaping (Result<[HotelModel], Error>) -> Void) -> Alamofire.Request
}

final class SurveyService : SurveyServiceProtocol {
    
    static let shared = SurveyService()
    
    let endpoint = baseURL
    
    func getSurveys(page: Int = 0, perPage: Int = 10, completionHandler: @escaping (Result<[HotelModel], Error>) -> Void) -> Alamofire.Request {
        let url = baseURL + "surveys.json?page=\(page)&per_page=\(perPage)"
        let params = ["access_token": UserManager.getAccessToken()]

        return AF.request(url, method: .get, parameters: params).responseJSON(completionHandler: { response in

            if let dictionaryItems = response.value as? [[String: Any]] {
                let listPosts = dictionaryItems.map({ (dic) -> HotelModel in
                    return HotelModel(JSON: dic)!
                })
                completionHandler(.success(listPosts))
            } else if let error = response.error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.failure(NetworkError.init(description: "", code: 500)))
            }
        })
    }

}

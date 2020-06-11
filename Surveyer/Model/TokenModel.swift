//
//  UserModel.swift
//  Surveyer
//
//  Created by Pisit W on 11/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import Foundation
import ObjectMapper

class TokenModel: Mappable {
    
    var accessToken: String!
    var tokenType: String!
    var expiresIn: Float?
    var createAt: Float?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        accessToken <- map["access_token"]
        tokenType <- map["token_type"]
        expiresIn <- map["expires_in"]
        createAt <- map["created_at"]
    }
    
    var expiredTime: Float { get { return (expiresIn ?? 0) + (createAt ?? 0) }}
}

//
//  HotelModel.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import ObjectMapper

class HotelModel: Mappable {
    var title: String?
    var description: String?
    var questions: [QuestionModel]?
    var coverImageUrl: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        description <- map["description"]
        questions <- map["questions"]
        coverImageUrl <- map["cover_image_url"]
    }
}

class QuestionModel: Mappable {
    var text: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        text <- map["text"]
    }
}

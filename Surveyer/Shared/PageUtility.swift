//
//  PageUtility.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit
import ObjectMapper

class PageUtility: Mappable {
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        page     <- map["page"]
        totalPage         <- map["total_page"]
        totalItems            <- map["total_items"]
        perpage     <- map["perpage"]
    }
    
    var page: Int!
    var totalPage: Int!
    var totalItems: Int!
    var perpage: Int!
    
    func isLastPage() -> Bool {
        return page >= totalPage
    }
    
    func getNextPage() -> Int {
        return (page + 1)
    }
    
    init(page: Int, perPage: Int) {
        self.page = page
        self.perpage = perPage
    }
}


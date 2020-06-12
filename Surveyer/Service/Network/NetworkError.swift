//
//  BackendError.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit
import ObjectMapper

struct NetworkError: LocalizedError, Mappable {

    var code: Int?
    var error: String?
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(description: String, code: Int?) {
        self._description = description
        self.code = code
    }
    
    init?(map: Map) {
        self._description = ""
    }
    
    mutating func mapping(map: Map) {
        error <- map["error"]
        _description <- map["error_description"]
    }
}

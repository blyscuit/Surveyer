//
//  BackendError.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

struct NetworkError: LocalizedError {

    var code: Int?
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(description: String, code: Int?) {
        self._description = description
        self.code = code
    }
}

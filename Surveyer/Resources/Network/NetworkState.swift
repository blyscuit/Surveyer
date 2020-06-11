//
//  NetworkState.swift
//  Surveyer
//
//  Created by Pisit W on 11/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

enum NetworkState: Equatable {
    case none
    case loading
    case noInternet
    case successHaveValue
    case successNoValue
    case error
    case errorWith(errorCode: Int, errorMessage: String)
    case loadingMore
    case tokenExpired
    case progress(progress: Double)
    
    func isLoading() -> Bool {
        return self == NetworkState.loading
    }
    
    static func errorFromCode(errorCode: Int, errorMessage: String) -> NetworkState {
        return .errorWith(errorCode: errorCode, errorMessage: errorMessage)
    }
}

//
//  UserManager.swift
//  Surveyer
//
//  Created by Pisit W on 11/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import SwiftKeychainWrapper

var UserManager = UserManagerInstance.share
let userJsonKey = "USER_JSON_KEY"
let tokenFetchError = Notification.Name("tokenFetchError")

class UserManagerInstance: NSObject {
    
    static var share: UserManagerInstance = UserManagerInstance()
    var token: TokenModel?
    
    override init() {
        super.init()
        loadUser()
    }
    
    func saveToken(token: TokenModel?) -> Bool {
        guard let token = token else {
            return false
        }
        self.token = token
        KeychainWrapper.standard.set(token.toJSONString() ?? "", forKey: userJsonKey)
        guard let _ = token.accessToken else {
            return false
        }
        return true
    }
    
    func loadUser() {
        if let token = TokenModel(JSONString: KeychainWrapper.standard.string(forKey: userJsonKey) ?? "") {
            self.token = token
        } else {
            fetchToken()
        }
    }
    
    func isTokenAvailable() -> Bool {
        guard let token = token else {
            return false
        }
        return (token.accessToken != nil &&
            (Date(timeIntervalSince1970: TimeInterval((token.expiredTime)))).compare(Date()) != .orderedAscending)
    }
    
    func fetchToken(round: Int = 0, completionHandler: (() -> Void)? = nil) {
        if isTokenAvailable() {
            completionHandler?()
            return
        }
        
        if round < 3 {
            let _ = PostService.postLogin(username: "carlos@nimbl3.com", password: "antikera") { [weak self] (tokenModel, error) in
                guard let `self` = self else { return }
                if error != nil {
                    self.fetchToken(round: round+1, completionHandler: completionHandler)
                    return
                }
                guard let tokenModel = tokenModel else {
                    return
                }
                if self.saveToken(token: tokenModel) {
                    completionHandler?()
                }
            }
        } else {
            // some kind of error popup here
            NotificationCenter.default.post(name: tokenFetchError, object: nil)
        }
    }
    
    func getAccessToken() -> String {
        return UserManager.token?.accessToken ?? ""
    }
}

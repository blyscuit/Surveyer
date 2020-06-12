//
//  BaseViewController.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

//Any share variable or method
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        insertUIViews()
        bindObservable()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showUniversalErrorPopup), name: tokenFetchError, object: nil)
    }
    
    func insertUIViews() {}
    func bindObservable() {}

    @objc func showUniversalErrorPopup() {
        let alert = UIAlertController(title: "base.error.title", message: "base.error.message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "base.error.ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

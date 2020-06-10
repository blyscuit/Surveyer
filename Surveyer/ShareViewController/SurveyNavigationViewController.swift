//
//  SurveyNavigationViewController.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

/// Custom UINavigationController
/// For controlling look
class SurveyNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = .black
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

    }

}

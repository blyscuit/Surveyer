//
//  PageVerticalFlowLayout.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

class PageVerticalFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()

        scrollDirection = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

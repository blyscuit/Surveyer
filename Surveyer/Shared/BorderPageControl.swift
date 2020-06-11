//
//  BorderPageControl.swift
//  Surveyer
//
//  Created by Pisit W on 11/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

class BorderPageControl: UIPageControl {
    
    override public var currentPage: Int {
        didSet {
            refreshImagesOfDots()
        }
    }
    
    override public var numberOfPages: Int {
        didSet {
            refreshImagesOfDots()
        }
    }
    
    func refreshImagesOfDots() {
        customPageControl(dotFillColor: .white, dotBorderColor: .white, dotBorderWidth: 1)
    }
    
    func customPageControl(dotFillColor:UIColor, dotBorderColor:UIColor, dotBorderWidth:CGFloat) {
        for (pageIndex, dotView) in self.subviews.enumerated() {
            if self.currentPage == pageIndex {
                dotView.backgroundColor = dotFillColor
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
            }else{
                dotView.backgroundColor = .clear
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = dotBorderColor.cgColor
                dotView.layer.borderWidth = dotBorderWidth
            }
        }
    }
}

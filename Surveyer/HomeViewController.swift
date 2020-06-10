//
//  HomeViewController.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var surveyCollectionView: UICollectionView?
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Surveys", comment: "")
    }
    
    override func insertUIViews() {
        let surveyCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(surveyCollectionView)
        self.surveyCollectionView = surveyCollectionView
        
        view.addSubview(pageControl)
        pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        pageControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        pageControl.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2));
        pageControl.widthAnchor.constraint(equalToConstant: 20).isActive = true
        pageControl.numberOfPages = 10
    }

}

//
//  HomeViewController.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let viewModel = HomeViewModel()
    
    lazy var surveyCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    lazy var takeSurveyButton: LargeButton = {
        let b = LargeButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("home.header.surveys", comment: "")
        
        viewModel.getData()
    }
    
    override func insertUIViews() {
        view.addSubview(surveyCollectionView)
        
        view.addSubview(pageControl)
        pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        pageControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        pageControl.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2));
        pageControl.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(takeSurveyButton)
        takeSurveyButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        takeSurveyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        takeSurveyButton.title = NSLocalizedString("home.mainButton", comment: "")
        
        surveyCollectionView.dataSource = viewModel.dataSource
        surveyCollectionView.delegate = self
        
        
    }
    
    override func bindObservable() {
        viewModel.dataSource.data.addObserver(self) { [weak self] (model) in
            self?.surveyCollectionView.reloadData()
            self?.pageControl.numberOfPages = model.count
        }
    }

    @objc func refreshData(_ sender: UIControl) {
        viewModel.getData()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    // nothing here for now
}

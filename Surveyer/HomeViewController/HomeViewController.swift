//
//  HomeViewController.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    let dataSource = HomeSurveyDataSource()
    
    lazy var viewModel : HomeViewModel = {
        let viewModel = HomeViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    lazy var surveyCollectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = {
            let fl = UICollectionViewFlowLayout()
            fl.scrollDirection = .vertical
            fl.minimumLineSpacing = 0
            fl.minimumInteritemSpacing = 0
            return fl
        }()
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = BorderPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    lazy var takeSurveyButton: LargeButton = {
        let b = LargeButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.alpha = 0
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("home.header.surveys", comment: "")
        edgesForExtendedLayout = []
        
        viewModel.getData()
    }
    
    override func insertUIViews() {
        view.addSubview(surveyCollectionView)
        
        view.addSubview(pageControl)
        pageControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        pageControl.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2));
        pageControl.widthAnchor.constraint(equalToConstant: 20).isActive = true
        pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(takeSurveyButton)
        takeSurveyButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        takeSurveyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        takeSurveyButton.title = NSLocalizedString("home.mainButton", comment: "")
        
        surveyCollectionView.register(HomeSurveyCollectionViewCell.self, forCellWithReuseIdentifier: HomeSurveyCollectionViewCell.reuseId)
        
        surveyCollectionView.dataSource = dataSource
        surveyCollectionView.delegate = self
        surveyCollectionView.showsVerticalScrollIndicator = false
        
        (surveyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = self.surveyCollectionView.bounds.size
        
        takeSurveyButton.addTarget(self, action: #selector(presentDetail(_:)), for: .touchUpInside)
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
        self.navigationItem.leftBarButtonItem = refreshButton
        
        let organizeButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = organizeButton
    }
    
    override func bindObservable() {
        viewModel.dataSource?.data.addObserver(self) { [weak self] (model) in
            // use reloadSections instead of reloadData
            self?.surveyCollectionView.reloadSections([0])
            self?.pageControl.numberOfPages = model.count
            UIView.animate(withDuration: 0.3) {
                self?.takeSurveyButton.alpha = model.count == 0 ? 0 : 1
            }
        }
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        surveyCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func refreshData(_ sender: UIControl) {
        viewModel.getData()
    }
    
    @objc func presentDetail(_ sender: UIControl) {
        guard let model = viewModel.modelAtIndex(pageControl.currentPage) else { return }
        let vc = DetailViewController()
        vc.viewModel.hotelModel.value = model
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        let w = scrollView.bounds.size.height
        let currentPage = Int(ceil(x/w))
        pageControl.currentPage = currentPage
        
        // -4 or any number that make sense
        if currentPage > viewModel.getModelCount() - 4 {
            viewModel.getData(reset: false)
        }
    }
}

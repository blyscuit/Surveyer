//
//  HomeViewModel.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {
    let dataSource: HomeSurveyDataSource
    var pagination: PageUtility!

    override init() {
        dataSource = HomeSurveyDataSource()
        super.init()
    }
    
    func getData() {
        PostService.getSurveys { [weak self] (model, error) in
            guard let `self` = self, let model = model else { return }
            self.dataSource.data.value = model
        }
    }
}

class HomeSurveyDataSource: GenericDataSource<HotelModel>, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

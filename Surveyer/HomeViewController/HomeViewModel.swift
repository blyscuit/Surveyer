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
    
    override init() {
        dataSource = HomeSurveyDataSource()
        super.init()
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

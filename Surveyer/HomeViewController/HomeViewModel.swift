//
//  HomeViewModel.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeViewModel: NSObject {
    let dataSource: HomeSurveyDataSource
    var pagination: PageUtility!

    override init() {
        dataSource = HomeSurveyDataSource()
        super.init()
    }
    
    func getData() {
        UserManager.fetchToken {
            PostService.getSurveys { [weak self] (model, error) in
                guard let `self` = self, let model = model else { return }
                self.dataSource.data.value = model
            }
        }
    }
}

class HomeSurveyDataSource: GenericDataSource<HotelModel>, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSurveyCollectionViewCell.reuseId, for: indexPath) as? HomeSurveyCollectionViewCell
        let model = data.value[indexPath.row]
        // bind cell here or in Cell class with a custom method
        cell?.titleLabel.text = model.title
        cell?.descriptionLabel.text = model.description
        if let text = model.coverImageUrl, let url = URL(string: text) {
            cell?.imageView.af_setImage(withURL: url)
        }
        return cell ?? UICollectionViewCell()
    }
}

//
//  HomeSurveyDataSource.swift
//  Surveyer
//
//  Created by Pisit W on 12/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

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
        if let text = model.coverImageUrl, let url = URL(string: text), let urlLarge = URL(string: text+"l") {
            // it should be a more robust method of: if large finish first then we cancel small, or if network is slow never do large.
            cell?.imageView.af_setImage(withURL: url)
            cell?.imageView.af_setImage(withURL: urlLarge)
        }
        return cell ?? UICollectionViewCell()
    }
}

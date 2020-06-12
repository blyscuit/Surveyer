//
//  SurveyDataSourceTest.swift
//  SurveyerTests
//
//  Created by Pisit W on 12/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//



import XCTest
@testable import Surveyer


class SurveyDataSourceTest: XCTestCase {
    
    var dataSource : HomeSurveyDataSource!
    
    override func setUp() {
        super.setUp()
        dataSource = HomeSurveyDataSource()
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }
    
    func testEmptyValueInDataSource() {
        
        // giving empty data value
        dataSource.data.value = []
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = dataSource
        
        
        // expected zero cells
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), 0, "Expected no cell in col view")
    }
    
    func testValueInDataSource() {
        
        // giving data value
        let model1 = HotelModel(JSON: [:])!
        let model2 = HotelModel(JSON: [:])!
        dataSource.data.value = [model1, model2]
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = dataSource
        
        // expected two cells
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), 2, "Expected two cells")
    }
    
    func testValueCell() {
        
        // giving data value
        let model1 = HotelModel(JSON: [:])!
        dataSource.data.value = [model1]
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = dataSource
        collectionView.register(HomeSurveyCollectionViewCell.self, forCellWithReuseIdentifier: HomeSurveyCollectionViewCell.reuseId)
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        // expected HomeSurveyCollectionViewCell class
        guard let _ = dataSource.collectionView(collectionView, cellForItemAt: indexPath) as? HomeSurveyCollectionViewCell else {
            XCTAssert(false, "Expected HomeSurveyCollectionViewCell class")
            return
        }
    }
}

//
//  HomeViewModel.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class HomeViewModel: NSObject {
    let dataSource: GenericDataSource<HotelModel>?
    var pagination: PageUtility!
    var dataRequest: Alamofire.Request?
    var networkStatus: DynamicValue<NetworkState> = DynamicValue(.none)
    
    private var perPage = 10

    weak var service: SurveyServiceProtocol?

    init(service: SurveyServiceProtocol = SurveyService.shared, dataSource: GenericDataSource<HotelModel>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func getData(reset: Bool = true) {
        
        guard let service = service else {
            networkStatus.value = .error
            return
        }
        
        if networkStatus.value == .loadingMore { return }
        
        dataRequest?.cancel()
        
        if let pagination = pagination, pagination.isLastPage(), reset == false { return }

        let page = reset ? 0 : pagination?.getNextPage() ?? 0
        networkStatus.value = .loadingMore
        
        if reset {
            self.pagination = nil
        }
        
        UserManager.fetchToken {

            self.dataRequest = service.getSurveys(page: page, perPage: self.perPage) { [weak self] (model, error) in
                guard let `self` = self else {
                    return
                }
                guard let model = model else {
                    self.networkStatus.value = .error
                    return
                }
                if reset || self.pagination == nil {
                    self.pagination = PageUtility(page: page, perPage: self.perPage)
                    self.dataSource?.data.value = model
                } else {
                    self.pagination.page = page
                    self.pagination.perpage = self.perPage
                    self.dataSource?.data.value.append(contentsOf: model)
                }
                // baecause I don't know how API will handle last page, normally they could send total page value.
                if error == nil, model.count == 0 {
                    // last page
                    self.pagination.totalPage = self.pagination.page
                }
                self.networkStatus.value = .none
            }
        }
    }
    
    func modelAtIndex(_ index: Int) -> HotelModel? {
        guard let dataSource = dataSource else { return nil }
        if dataSource.data.value.count == 0 {
            return nil
        } else if (dataSource.data.value.count - 1) < index {
            return dataSource.data.value.last
        } else {
            return dataSource.data.value[index]
        }
    }
    
    func getModelCount() -> Int {
        guard let dataSource = dataSource else { return 0 }
        return dataSource.data.value.count
    }
}

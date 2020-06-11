//
//  DetailViewController.swift
//  Surveyer
//
//  Created by Pisit W on 11/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    let viewModel = DetailViewModel()
    
    lazy var stackView: UIStackView = {
        let s = UIStackView(frame: view.bounds)
        s.spacing = 16
        s.axis = .vertical
        return s
    }()
    
    lazy var titleLabel: UILabel = {
       let l = UILabel()
        l.font = .Title_NotoBold_24
        l.textAlignment = .center
        l.textColor = .black
        return l
    }()
    
    var hotelModel: HotelModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func insertUIViews() {
        super.insertUIViews()
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
    }
    
    override func bindObservable() {
        super.bindObservable()
        viewModel.hotelModel.addAndNotify(observer: self) { [weak self] (model) in
            guard let `self` = self, let model = model else {
                return
            }
            self.title = model.title
            self.titleLabel.text = "\(NSLocalizedString("detail.value", comment: "")) \(model.questions?.count ?? 0)"
        }
    }

}

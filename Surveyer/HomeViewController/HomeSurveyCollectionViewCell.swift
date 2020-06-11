//
//  HomeSurveyCollectionViewCell.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

class HomeSurveyCollectionViewCell: UICollectionViewCell {
    static let reuseId = "HomeSurveyCollectionViewCell"
    
    lazy var imageView: UIImageView = {
           let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = false
            imageView.translatesAutoresizingMaskIntoConstraints  = false
            return imageView
        }()
    
    lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.spacing = 16
        s.axis = .vertical
        return s
    }()
    
    lazy var titleLabel: UILabel = {
       let l = UILabel()
        l.font = .Title_NotoBold_24
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    lazy var descriptionLabel: UILabel = {
       let l = UILabel()
        // TODO: Find right unmber
        l.numberOfLines = 3
        l.font = .Body2_NotoRegular_14
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        self.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true

        self.addSubview(blurEffectView)
        blurEffectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurEffectView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        blurEffectView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        self.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        blurEffectView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

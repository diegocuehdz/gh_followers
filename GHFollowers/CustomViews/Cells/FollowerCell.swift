//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 07/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell
{
    static let kIdentifier = "FollowerCell"
    private let padding: CGFloat = 8.0
    
    let img_Avatar = GFImageView(frame: .zero)
    let lb_Username = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpInfo(_ follower: Follower) {
        lb_Username.text = follower.login
        
    }
    
    private func config() {
        addSubview(img_Avatar)
        addSubview(lb_Username)
        
        
        NSLayoutConstraint.activate([
            img_Avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            img_Avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            img_Avatar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            img_Avatar.heightAnchor.constraint(equalTo: img_Avatar.widthAnchor),
            
            lb_Username.topAnchor.constraint(equalTo: img_Avatar.bottomAnchor, constant: 12.0),
            lb_Username.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            lb_Username.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            lb_Username.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
}

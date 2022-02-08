//
//  GFImageView.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 07/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

class GFImageView: UIImageView
{
    let imgPlaceHolder = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func config() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = imgPlaceHolder
        translatesAutoresizingMaskIntoConstraints = false
    }
}

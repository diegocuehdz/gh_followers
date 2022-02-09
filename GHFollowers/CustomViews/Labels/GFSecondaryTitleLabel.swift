//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 08/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}

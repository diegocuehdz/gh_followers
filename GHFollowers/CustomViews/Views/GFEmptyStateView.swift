//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 07/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView
{
    private let lb_Title = GFTitleLabel(textAlignment: .center, fontSize: 28)
    private let img_Logo = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        lb_Title.text = message
        configure()
    }
    
    private func configure() {
        addSubview(lb_Title)
        addSubview(img_Logo)
        
        lb_Title.numberOfLines = 3
        lb_Title.textColor = .secondaryLabel
        
        img_Logo.image = UIImage(named: "empty-state-logo")
        
        lb_Title.translatesAutoresizingMaskIntoConstraints = false
        img_Logo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lb_Title.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            lb_Title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            lb_Title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            lb_Title.heightAnchor.constraint(equalToConstant: 200),
            
            img_Logo.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            img_Logo.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            img_Logo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            img_Logo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}

//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 24/02/20.
//  Copyright © 2020 Diego Cué Hernández. All rights reserved.
//

import UIKit

class GFTextField: UITextField
{
    //https://github.com/aaronbrethorst/SemanticUI
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure()
    {
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .search
        
        placeholder = "Enter a username"
    }
}

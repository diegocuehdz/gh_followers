//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 08/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

enum GFItemInfoType
{
    case repos, gists, followers, following
}

class GFItemInfoView: UIView
{
    private let lb_Title = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let lb_Counter = GFTitleLabel(textAlignment: .center, fontSize: 14)
    private let img_Symbol = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(img_Symbol)
        addSubview(lb_Title)
        addSubview(lb_Counter)
        
        img_Symbol.image = UIImage(named: "empty-state-logo")
    
        img_Symbol.translatesAutoresizingMaskIntoConstraints = false
        img_Symbol.contentMode = .scaleAspectFill
        img_Symbol.tintColor = .label
        
        NSLayoutConstraint.activate([
            img_Symbol.topAnchor.constraint(equalTo: self.topAnchor),
            img_Symbol.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            img_Symbol.heightAnchor.constraint(equalToConstant: 20),
            img_Symbol.widthAnchor.constraint(equalToConstant: 20),
            
            lb_Title.centerYAnchor.constraint(equalTo: img_Symbol.centerYAnchor),
            lb_Title.leadingAnchor.constraint(equalTo: img_Symbol.trailingAnchor, constant: 12),
            lb_Title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lb_Title.heightAnchor.constraint(equalToConstant: 18),
            
            lb_Counter.topAnchor.constraint(equalTo: img_Symbol.bottomAnchor, constant: 4),
            lb_Counter.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lb_Counter.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lb_Counter.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func setUpView(itemInfoType: GFItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            img_Symbol.image = UIImage(systemName: SFSymbols.imgRepos)
            lb_Title.text = "Public Repos"
        case .gists:
            img_Symbol.image = UIImage(systemName: SFSymbols.imgGists)
            lb_Title.text = "Public Gists"
        case .followers:
            img_Symbol.image = UIImage(systemName: SFSymbols.imgFollowers)
            lb_Title.text = "Followers"
        case .following:
            img_Symbol.image = UIImage(systemName: SFSymbols.imgFollowing)
            lb_Title.text = "Following"
        }
        lb_Counter.text = String(count)
    }
}

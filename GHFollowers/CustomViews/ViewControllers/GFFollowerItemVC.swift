//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 28/07/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC
{
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpItems()
    }

    private func setUpItems() {
        itemInfoViewOne.setUpView(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.setUpView(itemInfoType: .following, withCount: user.following)
        buttonAction.setUp(backgroundColor: .systemGreen, title: "Get Followers")
        buttonAction.addTarget(self, action: #selector(click_ShowFollowers), for: .touchUpInside)
    }
    
    @objc func click_ShowFollowers() {
        delegate?.didTapGetFollowers(user: self.user)
    }
}

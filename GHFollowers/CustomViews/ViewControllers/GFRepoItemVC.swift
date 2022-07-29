//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 28/07/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC
{
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpItems()
    }

    private func setUpItems() {
        itemInfoViewOne.setUpView(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.setUpView(itemInfoType: .gists, withCount: user.publicGists)
        buttonAction.setUp(backgroundColor: .systemPurple, title: "Github profile")
        buttonAction.addTarget(self, action: #selector(click_ShowProfile), for: .touchUpInside)
    }
    
    @objc func click_ShowProfile() {
        delegate?.didTapGitHubProfile(user: self.user)
    }
}

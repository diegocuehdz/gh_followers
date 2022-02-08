//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 18/08/21.
//  Copyright © 2021 Diego Cué Hernández. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

    var userName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
            switch result {
            case .failure(let error ):
                self.showGFAlertOnMainThread(title: "API error", message: error.rawValue, buttonTitle: "Ok")
            case .success(let listFollowers):
                dump(listFollowers)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

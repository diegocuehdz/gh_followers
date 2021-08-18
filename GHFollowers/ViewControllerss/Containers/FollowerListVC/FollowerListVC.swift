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
        
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .systemBackground
    }
}

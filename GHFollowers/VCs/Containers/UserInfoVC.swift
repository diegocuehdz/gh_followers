//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 08/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController
{
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationItem()
        loadData(userName: username)
    }
    
    private func configNavigationItem() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dimsissVC ))
        navigationItem.rightBarButtonItem = doneButton
    }
   
    func loadData(userName: String) {
        showLoading()
        NetworkManager.shared.service_GetUser(for: userName) { [weak self] result in
            guard let self = self else { return }
            self.hideLoading()
            switch result {
            case .failure(let error ):
                self.showGFAlertOnMainThread(title: "API error", message: error.rawValue, buttonTitle: "Ok")
            case .success(let userReturn):
                debugPrint(userReturn)
            }
        }
    }

    @objc func dimsissVC() {
        dismiss(animated: true)
    }
}

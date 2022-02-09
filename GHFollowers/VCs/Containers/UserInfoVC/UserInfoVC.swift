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
    var user: User!
    
    let view_Header = UIView()
    let view_ItemOne = UIView()
    let view_ItemTwo = UIView()
    
    var list_Views: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationItem()
        layoutUI()
        loadData(userName: username)
    }
    
    private func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        list_Views = [view_Header, view_ItemOne, view_ItemTwo]
        
        for viewItem in list_Views {
            self.view.addSubview(viewItem)
            viewItem.translatesAutoresizingMaskIntoConstraints = false
        
            NSLayoutConstraint.activate([
                viewItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                viewItem.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        view_ItemOne.backgroundColor = .blue
        view_ItemTwo.backgroundColor = .cyan
        
        NSLayoutConstraint.activate([
            view_Header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            view_Header.heightAnchor.constraint(equalToConstant: 180),
            
            view_ItemOne.topAnchor.constraint(equalTo: view_Header.bottomAnchor, constant: padding),
            view_ItemOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            view_ItemTwo.topAnchor.constraint(equalTo: view_ItemOne.bottomAnchor, constant: padding),
            view_ItemTwo.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }
    
    private func addSubViews() {
        self.addChildVC(UserInfoHeaderVC(user: self.user), to: view_Header)
    }
    
    private func addChildVC(_ childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
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
                self.user = userReturn
                DispatchQueue.main.async {
                    self.addSubViews()
                }
            }
        }
    }
    
    @objc func dimsissVC() {
        dismiss(animated: true)
    }
}

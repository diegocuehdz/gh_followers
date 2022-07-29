//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 08/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject
{
    func didTapGitHubProfile(user: User)
    func didTapGetFollowers(user: User)
}

class UserInfoVC: UIViewController
{
    weak var delegate: FollowerListVCDelegate?
    
    var username: String!
    var user: User!
    
    let view_Header = UIView()
    let view_ItemOne = UIView()
    let view_ItemTwo = UIView()
    let lb_Date = GFBodyLabel(textAlignment: .center)
    
    
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
        list_Views = [view_Header, view_ItemOne, view_ItemTwo, lb_Date]
        
        for viewItem in list_Views {
            self.view.addSubview(viewItem)
            viewItem.translatesAutoresizingMaskIntoConstraints = false
        
            NSLayoutConstraint.activate([
                viewItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                viewItem.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            view_Header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            view_Header.heightAnchor.constraint(equalToConstant: 180),
            
            view_ItemOne.topAnchor.constraint(equalTo: view_Header.bottomAnchor, constant: padding),
            view_ItemOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            view_ItemTwo.topAnchor.constraint(equalTo: view_ItemOne.bottomAnchor, constant: padding),
            view_ItemTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            lb_Date.topAnchor.constraint(equalTo: view_ItemTwo.bottomAnchor, constant: padding),
            lb_Date.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func addSubViewsWith(user: User) {
        
        let vcRepoItem = GFRepoItemVC.init(user: user)
        vcRepoItem.delegate = self
        
        let vcFollowersItem = GFFollowerItemVC.init(user: user)
        vcFollowersItem.delegate = self
        
        self.lb_Date.text = "Github since \(user.createdAt.converToDisplayFormat())"
        self.addChildVC(UserInfoHeaderVC(user: user), to: view_Header)
        self.addChildVC(vcRepoItem, to: view_ItemOne)
        self.addChildVC(vcFollowersItem, to: view_ItemTwo)
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
                DispatchQueue.main.async { self.addSubViewsWith(user: self.user) }
            }
        }
    }
    
    @objc func dimsissVC() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: UserInfoVCDelegate
{
    func didTapGetFollowers(user: User) {
        guard user.followers != 0 else {
            showGFAlertOnMainThread(title: "Now Followers", message: "This user has no followers.", buttonTitle: "Ok")
            return
        }
        
        dismiss(animated: true) {
            self.delegate?.didRequestFollowers(userName: user.login)
        }
    }
    
    func didTapGitHubProfile(user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            showGFAlertOnMainThread(title: "Invalid URL", message: "The URL attached for this user is not valid", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(url: url)
    }
}

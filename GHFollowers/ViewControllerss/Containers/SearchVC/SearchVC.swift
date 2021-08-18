//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 23/02/20.
//  Copyright © 2020 Diego Cué Hernández. All rights reserved.
//

import UIKit

class SearchVC: UIViewController
{
    let img_Logo = UIImageView()
    let tf_UserName = GFTextField()
    let btn_Search = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func setUp() {
        setUp_ImgLogo()
        setUp_TfUserName()
        setUp_BtnSearch()
    }
    
    func setUp_ImgLogo() {
        view.addSubview(img_Logo)
        img_Logo.translatesAutoresizingMaskIntoConstraints = false
        img_Logo.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            img_Logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            img_Logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            img_Logo.heightAnchor.constraint(equalToConstant: 200),
            img_Logo.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setUp_TfUserName() {
        view.addSubview(tf_UserName)
        tf_UserName.delegate = self
        
        NSLayoutConstraint.activate([
            tf_UserName.topAnchor.constraint(equalTo: img_Logo.bottomAnchor, constant:48),
            tf_UserName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            tf_UserName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            tf_UserName.heightAnchor.constraint(equalToConstant: 50)
        ])
    
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func setUp_BtnSearch() {
        view.addSubview(btn_Search)
        NSLayoutConstraint.activate([
            btn_Search.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            btn_Search.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            btn_Search.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            btn_Search.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        btn_Search.addTarget(self, action: #selector(click_Next), for: .touchUpInside)
    }
    
    @objc func click_Next(){
        
        guard let searchUserName = tf_UserName.text else { return }
        if searchUserName.isEmpty { return }
        
        let vcFollowers = FollowerListVC.init()
        vcFollowers.userName = searchUserName
        vcFollowers.title = searchUserName
        navigationController?.pushViewController(vcFollowers, animated: true)
    }
}


extension SearchVC: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tf_UserName.resignFirstResponder()
        click_Next()
        return true
    }
}

//
//  UserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 08/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

class UserInfoHeaderVC: UIViewController
{
    var user: User!
    
    let img_Avatar = GFImageView(frame: .zero)
    let lb_UserName = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let lb_Name = GFSecondaryTitleLabel(fontSize: 18)
    let img_Location = UIImageView()
    let lb_Location = GFSecondaryTitleLabel(fontSize: 18)
    let lb_Bio = GFBodyLabel(textAlignment: .left)
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        layoutUI()
        configUIElements()
    }
    
    func configUIElements() {
        img_Avatar.downloadImage(from: user.avatarUrl)
        lb_UserName.text = user.login
        lb_Name.text = user.name ?? "Not specified"
        lb_Location.text = user.location ?? "Not location"
        lb_Bio.text = user.bio ?? "No bio written"
        lb_Bio.numberOfLines = 3
        
        img_Location.image = UIImage(systemName: SFSymbols.imgLocationName)
        img_Location.tintColor = .secondaryLabel
    }
    
    private func addSubViews() {
        view.addSubview(img_Avatar)
        view.addSubview(lb_UserName)
        view.addSubview(lb_Name)
        view.addSubview(img_Location)
        view.addSubview(lb_Location)
        view.addSubview(lb_Bio)
    }
    
    func layoutUI() {
//        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        img_Location.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            img_Avatar.topAnchor.constraint(equalTo: view.topAnchor),
            img_Avatar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            img_Avatar.widthAnchor.constraint(equalToConstant: 90),
            img_Avatar.heightAnchor.constraint(equalToConstant: 90),
            
            lb_UserName.topAnchor.constraint(equalTo: img_Avatar.topAnchor),
            lb_UserName.leadingAnchor.constraint(equalTo: img_Avatar.trailingAnchor, constant: textImagePadding),
            lb_UserName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lb_UserName.heightAnchor.constraint(equalToConstant: 38),
            
            lb_Name.centerYAnchor.constraint(equalTo: img_Avatar.centerYAnchor, constant: 8),
            lb_Name.leadingAnchor.constraint(equalTo: img_Avatar.trailingAnchor, constant: textImagePadding),
            lb_Name.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lb_Name.heightAnchor.constraint(equalToConstant: 20),

            img_Location.bottomAnchor.constraint(equalTo: img_Avatar.bottomAnchor),
            img_Location.leadingAnchor.constraint(equalTo: img_Avatar.trailingAnchor, constant: textImagePadding),
            img_Location.heightAnchor.constraint(equalToConstant: 20),
            img_Location.widthAnchor.constraint(equalToConstant: 20),
            
            lb_Location.centerYAnchor.constraint(equalTo: img_Location.centerYAnchor),
            lb_Location.leadingAnchor.constraint(equalTo: img_Location.trailingAnchor, constant: 5),
            lb_Location.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lb_Location.heightAnchor.constraint(equalToConstant: 20),
            
            lb_Bio.topAnchor.constraint(equalTo: img_Avatar.bottomAnchor, constant: textImagePadding),
            lb_Bio.leadingAnchor.constraint(equalTo: img_Avatar.leadingAnchor),
            lb_Bio.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lb_Location.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 28/07/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController
{
    open var user: User!
    weak var delegate: UserInfoVCDelegate?
    
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let buttonAction = GFButton()
    
   
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        setUpStackView()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func setUpStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(buttonAction)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            buttonAction.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            buttonAction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            buttonAction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            buttonAction.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}

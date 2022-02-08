//
//  GFAlertViewVC.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 07/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

class GFAlertViewVC: UIViewController
{
    let view_Container = GFContainerView()
    let lb_Title = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let lb_Message = GFBodyLabel(textAlignment: .center)
    let btn_Action = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle: String?
    var alertMessage: String?
    var alertButtonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.alertMessage = message
        self.alertButtonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.75)
        configContainerView()
        configTitleLabel()
        configButtonAction()
        configMessageLabel()
    }
    
    func configContainerView() {
        self.view.addSubview(view_Container)
    
        NSLayoutConstraint.activate([
            view_Container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view_Container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view_Container.widthAnchor.constraint(equalToConstant: 280),
            view_Container.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configTitleLabel() {
        view_Container.addSubview(lb_Title)
        lb_Title.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            lb_Title.topAnchor.constraint(equalTo: view_Container.topAnchor, constant: padding),
            lb_Title.leadingAnchor.constraint(equalTo: view_Container.leadingAnchor, constant: padding),
            lb_Title.trailingAnchor.constraint(equalTo: view_Container.trailingAnchor, constant: -padding),
            lb_Title.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configButtonAction() {
        view_Container.addSubview(btn_Action)
        btn_Action.titleLabel?.text = alertButtonTitle ?? "Ok"
        
        btn_Action.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            btn_Action.bottomAnchor.constraint(equalTo: view_Container.bottomAnchor, constant: -padding),
            btn_Action.leadingAnchor.constraint(equalTo: view_Container.leadingAnchor, constant: padding),
            btn_Action.trailingAnchor.constraint(equalTo: view_Container.trailingAnchor, constant: -padding),
            btn_Action.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func configMessageLabel() {
        view_Container.addSubview(lb_Message)
        lb_Message.text = alertMessage ?? "Unable to complete request"
        lb_Message.numberOfLines = 4
        NSLayoutConstraint.activate([
            lb_Message.topAnchor.constraint(equalTo: lb_Title.bottomAnchor, constant: 8.0),
            lb_Message.leadingAnchor.constraint(equalTo: view_Container.leadingAnchor, constant: padding),
            lb_Message.trailingAnchor.constraint(equalTo: view_Container.trailingAnchor, constant: -padding),
            lb_Message.bottomAnchor.constraint(equalTo: btn_Action.topAnchor, constant: -12.0)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}


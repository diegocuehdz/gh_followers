//
//  UIViewController+Utils.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 07/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController
{
    func showGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertViewVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoading() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        DispatchQueue.main.async {
            let view_EmptyState = GFEmptyStateView(message: message)
            view_EmptyState.frame = view.bounds
            view.addSubview(view_EmptyState)
        }
    }
    
    func presentSafariVC(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .popover
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}

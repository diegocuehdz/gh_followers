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
    var collectionView_Followers: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configCollectionView()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configViewController() {
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func loadData() {
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
            switch result {
            case .failure(let error ):
                self.showGFAlertOnMainThread(title: "API error", message: error.rawValue, buttonTitle: "Ok")
            case .success(let listFollowers):
                dump(listFollowers)
            }
        }
    }
    
    func configCollectionView() {
        self.collectionView_Followers = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewFlowLayout())
        view.addSubview(collectionView_Followers)
        collectionView_Followers.backgroundColor = .systemPink
        collectionView_Followers.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.kIdentifier)
    }
    
    func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let numItemsPerRow: CGFloat = 3.0
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let widthPerItem = availableWidth/numItemsPerRow
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: widthPerItem, height: widthPerItem + 40)
        return flowLayout
    }
    
}

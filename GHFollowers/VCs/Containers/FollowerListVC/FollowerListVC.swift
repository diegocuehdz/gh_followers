//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 18/08/21.
//  Copyright © 2021 Diego Cué Hernández. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum CollectionSectionDefault { case main }
    
    var userName: String = ""
    var collectionView_Followers: UICollectionView!
    var dataSourceDiff: UICollectionViewDiffableDataSource<CollectionSectionDefault, Follower>!
    
    var list_Followers: [Follower] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configViewController()
        configCollectionView()
        configDataSource()
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
        NetworkManager.shared.service_GetFollowerList(for: userName, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error ):
                self.showGFAlertOnMainThread(title: "API error", message: error.rawValue, buttonTitle: "Ok")
            case .success(let listFollowers):
                self.list_Followers = listFollowers
                self.updateData()
                dump(listFollowers)
            }
        }
    }
    
    func configCollectionView() {
        self.collectionView_Followers = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView_Followers)
        collectionView_Followers.backgroundColor = .systemBackground
        collectionView_Followers.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.kIdentifier)
    }
    
    func configDataSource() {
        dataSourceDiff = UICollectionViewDiffableDataSource<CollectionSectionDefault, Follower>(collectionView: collectionView_Followers, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.kIdentifier, for: indexPath) as! FollowerCell
            cell.setUpInfo(itemIdentifier)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionSectionDefault, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list_Followers)
        DispatchQueue.main.async {
            self.dataSourceDiff.apply(snapshot, animatingDifferences: true)
        }
    }
}

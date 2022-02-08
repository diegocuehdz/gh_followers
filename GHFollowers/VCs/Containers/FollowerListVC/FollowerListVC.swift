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
    
    
    var collectionView_Followers: UICollectionView!
    var dataSourceDiff: UICollectionViewDiffableDataSource<CollectionSectionDefault, Follower>!
    
    var userName: String = ""
    var list_Followers: [Follower] = []
    var page: Int = 1
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViewController()
        configCollectionView()
        loadData(userName: userName, page: page)
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
    
    func loadData(userName: String, page: Int) {
        showLoading()
        NetworkManager.shared.service_GetFollowerList(for: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            self.hideLoading()
            switch result {
            case .failure(let error ):
                self.showGFAlertOnMainThread(title: "API error", message: error.rawValue, buttonTitle: "Ok")
            case .success(let listFollowers):
                if listFollowers.count < 100 { self.hasMoreFollowers = false }
                self.list_Followers.append(contentsOf: listFollowers)
                if self.list_Followers.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "This User doesn't have any followers. Go follow them 😉", in: self.view)
                    }
                }
                self.updateData()
            }
        }
    }
    
    func configCollectionView() {
        self.collectionView_Followers = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView_Followers)
        collectionView_Followers.delegate = self
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

extension FollowerListVC: UICollectionViewDelegate
{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            loadData(userName: userName, page: page)
        }
    }
}

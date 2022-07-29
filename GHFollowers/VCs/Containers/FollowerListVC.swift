//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 18/08/21.
//  Copyright © 2021 Diego Cué Hernández. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject
{
    func didRequestFollowers(userName: String)
}


class FollowerListVC: UIViewController
{
    enum CollectionSectionDefault { case main }
    
    
    var collectionView_Followers: UICollectionView!
    var dataSourceDiff: UICollectionViewDiffableDataSource<CollectionSectionDefault, Follower>!
    
    var userName: String = ""
    var list_Followers: [Follower] = []
    var list_FollowersFiltered: [Follower] = []
    
    var page: Int = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViewController()
        configCollectionView()
        configSearchController()
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
                self.updateData(on: self.list_Followers)
            }
        }
    }
    
    func configSearchController() {
        let searchVC = UISearchController()
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.delegate = self
        searchVC.searchBar.placeholder = "Search for a username…"
        navigationItem.searchController = searchVC
        //        searchVC.obscuresBackgroundDuringPresentation = false
    }
    
    func configCollectionView() {
        self.collectionView_Followers = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView_Followers)
        collectionView_Followers.delegate = self
        collectionView_Followers.backgroundColor = .systemBackground
        collectionView_Followers.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.kIdentifier)
//        collectionView_Followers.alwaysBounceVertical = true
    }
    
    func configDataSource() {
        dataSourceDiff = UICollectionViewDiffableDataSource<CollectionSectionDefault, Follower>(collectionView: collectionView_Followers, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.kIdentifier, for: indexPath) as! FollowerCell
            cell.setUpInfo(itemIdentifier)
            return cell
        })
    }
    
    func updateData(on listFollowers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionSectionDefault, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(listFollowers)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let followerSelected = (isSearching ? list_FollowersFiltered : list_Followers)[indexPath.item]
        let vcUserInfo = UserInfoVC()
        vcUserInfo.delegate = self
        vcUserInfo.username = followerSelected.login
        let navController = UINavigationController(rootViewController: vcUserInfo)
        present(navController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate
{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        list_FollowersFiltered = list_Followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: list_FollowersFiltered)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: self.list_Followers)
    }
}

extension FollowerListVC: FollowerListVCDelegate
{
    func didRequestFollowers(userName: String) {
        self.userName = userName
        title = userName
        page = 1
        list_Followers.removeAll()
        list_FollowersFiltered.removeAll()
        
        loadData(userName: userName, page: 1)
    }
}

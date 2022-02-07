//
//  SceneDelegate.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 23/02/20.
//  Copyright © 2020 Diego Cué Hernández. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
        
        configNavigationBar()
    }
    
    func createTabBar() -> UITabBarController
    {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        
        tabBar.viewControllers = [createSearchNC(), createFavoritesNC()]

        return tabBar
    }
    
    func createSearchNC() -> UINavigationController
    {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController
    {
        let favoritesVC = FavoritesListVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)

        
        return UINavigationController(rootViewController: favoritesVC)
    }
   
    func configNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }

    func sceneDidDisconnect(_ scene: UIScene)
    {
    
    }

    func sceneDidBecomeActive(_ scene: UIScene)
    {
    
    }

    func sceneWillResignActive(_ scene: UIScene)
    {
    
    }

    func sceneWillEnterForeground(_ scene: UIScene)
    {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene)
    {
        
    }
}


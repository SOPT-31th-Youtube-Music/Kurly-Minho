//
//  TabBarController.swift
//  Kurly
//
//  Created by 김민 on 2022/11/29.
//

import UIKit

// MARK: - TabBarController

class TabBarController: UITabBarController {
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        tabBar.frame.size.height = 90
        tabBar.frame.origin.y = view.frame.height - 90
    }
}

// MARK: - Extension

extension TabBarController {
    
    private func setTabBar() {
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .kurlyPurple
        
        let homeTab = UINavigationController(rootViewController: HomeViewController())
        homeTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let categoryTab = UINavigationController(rootViewController: CategoryViewController())
        categoryTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "line.3.horizontal"), selectedImage: UIImage(systemName: "line.3.horizontal"))
    
        let searchTab = UINavigationController(rootViewController: SearchViewController())
        searchTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        let profileTab = UINavigationController(rootViewController: ProfileViewController())
        profileTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        let tabs = [homeTab, categoryTab, searchTab, profileTab]
        
        for vc in tabs {
            vc.view.backgroundColor = .white
            vc.navigationBar.isHidden = true
        }
        
        self.setViewControllers(tabs, animated: false)
    }
}

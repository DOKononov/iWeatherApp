//
//  MainTabBarController.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 20.03.22.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupTabBarUI()
    }
    
    private func setupTabBar() {

        viewControllers = [MainVC.tabBarInstance,
                           UINavigationController(rootViewController: CitiesVC.tabBarInstance)]
    }
    
    
    private func setupTabBarUI() {
        tabBarItem.badgeColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
    }
    
}

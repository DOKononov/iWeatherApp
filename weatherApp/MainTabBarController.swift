//
//  MainTabBarController.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 20.03.22.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupTabBarUI()
    }
    
    private func setupTabBar() {
        //        let mainVC = UINavigationController(rootViewController: MainVC())
        let mainVC = MainVC()
        mainVC.tabBarItem.image = UIImage(systemName: "star")
        mainVC.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        let citiesVC = UINavigationController(rootViewController: CitiesVC())
        
//        let citiesVC = CitiesVC()
        
        citiesVC.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        citiesVC.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        
        viewControllers = [mainVC, citiesVC]
    }
    
    
    private func setupTabBarUI() {
        tabBarItem.badgeColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
    }
    
}

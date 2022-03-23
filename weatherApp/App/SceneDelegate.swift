//
//  SceneDelegate.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 7.03.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
//        let mainVC = MainVC(nibName:  "\(MainVC.self)", bundle: nil)
//        window?.rootViewController = mainVC
//        window?.makeKeyAndVisible()
        
        let tabVC = MainTabBarController(nibName: "\(MainTabBarController.self)", bundle: nil)
        window?.rootViewController = tabVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataService.shared.saveContext()
    }


}


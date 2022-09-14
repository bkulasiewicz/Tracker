//
//  SceneDelegate.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 08/09/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var navigationController = UINavigationController()
    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
        
            coordinator = MainCoordinator(navigationController)
            coordinator?.showMainDashboard()
            
            window.rootViewController = navigationController
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}


//
//  SceneDelegate.swift
//  Navigation
//
//  Created by roman Khilchenko on 08.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarViewController = TabBarViewController()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarViewController
        self.window = window
        window.makeKeyAndVisible()
    }
    
}

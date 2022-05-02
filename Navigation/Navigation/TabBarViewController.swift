//
//  TabBarViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let logInViewController = LogInViewController()
    let feedViewController = FeedViewController()
    let profileViewController = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpController()
        
    }
    
    private func setUpController() {
        
        let feedController = UINavigationController(rootViewController: feedViewController)
        feedViewController.tabBarItem.title = "Лента"
        feedViewController.tabBarItem.image = UIImage(systemName: "play.circle")
        feedViewController.navigationItem.title = "Feed"
        
        
        let profileController = UINavigationController(rootViewController: logInViewController)
        logInViewController.tabBarItem.title = "Профиль"
        logInViewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        logInViewController.navigationItem.title = "Profile"
        
        viewControllers = [feedController, profileController]
    }
    
}

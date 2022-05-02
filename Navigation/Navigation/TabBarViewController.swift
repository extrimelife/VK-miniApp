//
//  TabBarViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
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
        
        let profileController = UINavigationController(rootViewController: profileViewController)
        profileViewController.tabBarItem.title = "Профиль"
        profileViewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        profileViewController.navigationItem.title = "Profile"
        viewControllers = [feedController, profileController]
    }
    
}


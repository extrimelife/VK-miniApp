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
        setupNavigationController()
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
    
    private func setupNavigationController() {
        let navigationBar = UINavigationBarAppearance()
        navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance =  navigationBar
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBar
        view.backgroundColor = .white
       
        
    }
    
}

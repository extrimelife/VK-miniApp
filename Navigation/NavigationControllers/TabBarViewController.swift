//
//  TabBarViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Private Properties
    
    private let logInViewController = LogInViewController()
    private let mainViewController = MainViewController()
    private let profileViewController = ProfileViewController()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupNavigationController()
    }
    
    // MARK: - Private Methods
    
    private func setupController() {
        let mainController = UINavigationController(rootViewController: mainViewController)
        mainController.tabBarItem.title = "Лента"
        mainController.tabBarItem.image = UIImage(systemName: "play.circle")
        mainController.navigationItem.title = "Main"
        
        let profileController = UINavigationController(rootViewController: logInViewController)
        logInViewController.tabBarItem.title = "Профиль"
        logInViewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        viewControllers = [mainController, profileController]
    }
    
    private func setupNavigationController() {
        let navigationBar = UINavigationBarAppearance()
        navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance =  navigationBar
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBar
        view.backgroundColor = .white
    }
}

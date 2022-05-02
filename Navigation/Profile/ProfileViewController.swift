//
//  ProfileViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()
    
    private let newButton: UIButton = {
        let buttonNew = UIButton()
        buttonNew.translatesAutoresizingMaskIntoConstraints = false
        buttonNew.backgroundColor = .blue
        buttonNew.tintColor = .white
        buttonNew.setTitle("New Post", for: .normal)
        buttonNew.layer.shadowOffset = CGSize(width: 4, height: 4)
        return buttonNew
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupAutoLayout()
        
    }
    
    private func setupNavigationController() {
        let navigationBar = UINavigationBarAppearance()
        navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance =  navigationBar
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBar
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        view.addSubview(newButton)
    }
    
    
    private func setupAutoLayout() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //constrain для subview
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            // constrain для UIbutton
            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

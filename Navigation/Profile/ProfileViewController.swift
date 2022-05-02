//
//  ProfileViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
    }
    
    override func viewWillLayoutSubviews() {
        profileHeaderView.frame = view.safeAreaLayoutGuide.layoutFrame
        
    }
    
}

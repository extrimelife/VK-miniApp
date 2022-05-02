//
//  PostViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

class PostViewController: UIViewController {
    var post:Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        makeBarItem()
        view.backgroundColor = .cyan
        
    }
    private func setupController() {
        if let post = post {
            self.title = post.title
        } else {
            self.title = "Default title"
        }
    }
    
    private func makeBarItem() {
        let barItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(tapAction))
        navigationItem.rightBarButtonItem = barItem
    }
    
    @objc private func tapAction () {
        let infoVc = InfoViewController()
        present(infoVc, animated: true)
    }
}

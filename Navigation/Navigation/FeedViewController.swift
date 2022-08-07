//
//  FeedViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let viewStack = UIStackView()
        viewStack.translatesAutoresizingMaskIntoConstraints = false
        viewStack.axis = .vertical
        viewStack.distribution = .fillEqually
        viewStack.spacing = 10
        return viewStack
    }()
    
    private lazy var setButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .brown
        button.tintColor = .white
        button.setTitle("Go to Post", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var viewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .label
        button.tintColor = .white
        button.setTitle("Go to Post", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(didAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackVc()
        
    }
    
    @objc private func tapAction() {
        let postViewController = PostViewController()
        postViewController.post = Post(title: "Post")
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    
    @objc private func didAction() {
        let postViewController = PostViewController()
        postViewController.post = Post(title: "Post")
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private func stackVc() {
        view.backgroundColor = .yellow
        view.addSubview(stackView)
        [setButton, viewButton] .forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}

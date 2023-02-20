//
//  FeedViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let stackView: UIStackView = {
        let viewStack = UIStackView()
        viewStack.translatesAutoresizingMaskIntoConstraints = false
        viewStack.axis = .vertical
        viewStack.distribution = .fillEqually
        viewStack.spacing = 10
        return viewStack
    }()
    
    private lazy var firstButton: UIButton = {
        let firstButton = setupButton(backgroundColor: .red)
        firstButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return firstButton
    }()
    
    private lazy var secondButton: UIButton = {
        let secondButton = setupButton(backgroundColor: .systemMint)
        secondButton.addTarget(self, action: #selector(didAction), for: .touchUpInside)
        return secondButton
    }()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    @objc private func buttonPressed() {
        let postViewController = PostViewController()
        postViewController.post = Post(title: "Post")
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc private func didAction() {
        let postViewController = PostViewController()
        postViewController.post = Post(title: "Post")
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private func setupLayout() {
        view.backgroundColor = .yellow
        view.addSubview(stackView)
        [firstButton, secondButton] .forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}

// MARK: - Extensions MainViewController

private func setupButton(backgroundColor: UIColor) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = backgroundColor
    button.tintColor = .white
    button.setTitle("Go to Post", for: .normal)
    button.layer.cornerRadius = 4
    button.layer.shadowOffset = CGSize(width: 4, height: 4)
    button.layer.shadowRadius = 4
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.7
    return button
}

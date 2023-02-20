//
//  ShowPostViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 17.05.2022.
//

import UIKit

final class ShowPostViewController: UIViewController {
    
    // MARK: - Public Properties
    
    let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        setupLabel(numberOfLines: 2, textColor: .black, font: UIFont.systemFont(ofSize: 20, weight: .bold))
    }()
    
    lazy var descriptionView: UILabel = {
        setupLabel(numberOfLines: 0, textColor: .systemGray, font: UIFont.systemFont(ofSize: 14, weight: .regular))
    }()
    
    // MARK: - Private Properties
    
    // Дополнительная view для scrollView без нее не будет работать scroll!!!
    private let viewContent: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let scrollView: UIScrollView = {
        let viewScroll = UIScrollView()
        viewScroll.translatesAutoresizingMaskIntoConstraints = false
        return viewScroll
    }()
    
    private lazy var likesLabel: UILabel = {
        setupLabel(numberOfLines: 0, textColor: .black, font: UIFont.systemFont(ofSize: 16, weight: .regular))
    }()
    
    private let viewLabel: UILabel = {
        let label = setupLabel(numberOfLines: 0, textColor: .black, font: UIFont.systemFont(ofSize: 16, weight: .regular))
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setLayout()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Описание"
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setLayout() {
        view.backgroundColor = .systemGray6
        view.addSubview(scrollView)
        scrollView.addSubview(viewContent)
        
        [titleLabel, photoView, descriptionView, likesLabel, viewLabel] .forEach { viewContent.addSubview($0) }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: photoView.centerXAnchor),
            
            photoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            photoView.leadingAnchor.constraint(equalTo: viewContent.safeAreaLayoutGuide.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: viewContent.safeAreaLayoutGuide.trailingAnchor),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor),
            
            descriptionView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 16),
            descriptionView.leadingAnchor.constraint(equalTo: viewContent.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionView.trailingAnchor.constraint(equalTo: viewContent.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16),
            likesLabel.trailingAnchor.constraint(equalTo: viewContent.centerXAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -16),
            
            viewLabel.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 16),
            viewLabel.leadingAnchor.constraint(equalTo: viewContent.centerXAnchor),
            viewLabel.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16),
            viewLabel.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -16),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            viewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

// MARK: - Extentions ShowPostViewController

private func setupLabel(numberOfLines: Int, textColor: UIColor, font: UIFont) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = numberOfLines
    label.textColor = textColor
    label.font = font
    return label
}

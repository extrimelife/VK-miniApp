//
//  ShowPostViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 17.05.2022.
//

import UIKit

// Контроллер для просмотра описания моих постов!
class ShowPostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.backgroundColor = .systemGray6
        navigationItem.title = "Описание"
        navigationController?.navigationBar.isHidden = false
    }
    
    var scrollView: UIScrollView = {
        let viewScroll = UIScrollView()
        viewScroll.translatesAutoresizingMaskIntoConstraints = false
        return viewScroll
    }()
    
    // Дополнительная view для scrollView без нее не будет работать scroll!!!
    var  viewContent: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    var titleLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        labelTitle.textColor = .black
        labelTitle.numberOfLines = 2
        return labelTitle
    }()
    
    var  photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var  descriptionView: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .systemGray
        textView.numberOfLines = 0
        return textView
    }()
    
    var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let viewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    
    private func setLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewContent)
        
        [titleLabel, photoView, descriptionView, likesLabel, viewLabel] .forEach { viewContent.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            // Констрейнт для titleView
            titleLabel.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: photoView.centerXAnchor),
            
            // Констрейнт для imageView
            photoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            photoView.leadingAnchor.constraint(equalTo: viewContent.safeAreaLayoutGuide.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: viewContent.safeAreaLayoutGuide.trailingAnchor),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor),
            
            // Констрейнт для описания
            descriptionView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 16),
            descriptionView.leadingAnchor.constraint(equalTo: viewContent.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionView.trailingAnchor.constraint(equalTo: viewContent.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // Констрейнт для лайков
            likesLabel.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16),
            likesLabel.trailingAnchor.constraint(equalTo: viewContent.centerXAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -16),
            
            // Констрейнт для просмотров
            viewLabel.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 16),
            viewLabel.leadingAnchor.constraint(equalTo: viewContent.centerXAnchor),
            viewLabel.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16),
            viewLabel.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -16),
            
            
            // Констрейнт для scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Констрейнт для contentView
            viewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
}

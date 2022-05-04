//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by roman Khilchenko on 03.05.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    private let whiteView: UIView = {
        let viewWhite = UIView()
        viewWhite.translatesAutoresizingMaskIntoConstraints = false
        return viewWhite
    }()
    
    private let titleLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        labelTitle.textColor = .black
        labelTitle.numberOfLines = 2
        return labelTitle
    }()
    
    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let descriptionView: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .systemGray
        textView.numberOfLines = 0
        return textView
    }()
    
    private let likesLabel: UILabel = {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ model: ModelPost) {
        titleLabel.text = model.author
        photoView.image = UIImage(named: model.image)
        descriptionView.text = model.description
        likesLabel.text = "Likes: \(model.likes)"
        viewLabel.text = "Views: \(model.views)"
        
    }
    
    private func layoutSetup() {
        [whiteView, titleLabel, photoView, descriptionView, likesLabel, viewLabel] .forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            // Констрейнт для ячейки
            whiteView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            whiteView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            whiteView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            
            // Констрейнт для titleView
            titleLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),
            
            // Констрейнт для imageView
            photoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            photoView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor),
            
            // Констрейнт для описания
            descriptionView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 16),
            descriptionView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            descriptionView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),
            
            // Констрейнт для лайков
            likesLabel.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            likesLabel.trailingAnchor.constraint(equalTo: whiteView.centerXAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -16),
            
            // Констрейнт для просмотров
            viewLabel.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 16),
            viewLabel.leadingAnchor.constraint(equalTo: whiteView.centerXAnchor),
            viewLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),
            viewLabel.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -16)
        ])
    }
    
}

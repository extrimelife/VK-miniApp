//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by roman Khilchenko on 03.05.2022.
//

import UIKit

// MARK: - Protocol TapPostImageDelegate
// Протокол для перехода к полному описанию поста с счетчиком просмотров
protocol TapPostImageDelegate: AnyObject {
    func postImagePress(author: String, description: String, image: String)
}

final class PostTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    weak var tapPostImageDelegate: TapPostImageDelegate?
    
    // MARK: - Private Properties
    
    private var modelPost = ModelPost(author: "", description: "", image: "", likes: 1, views: 1)
    
    private let whiteView: UIView = {
        let viewWhite = UIView()
        viewWhite.translatesAutoresizingMaskIntoConstraints = false
        return viewWhite
    }()
    
    private var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        setupLabel(textColor: .black, numberOfLines: 2, font: UIFont.systemFont(ofSize: 20, weight: .bold))
    }()
    
    private lazy var descriptionView: UILabel = {
        setupLabel(textColor: .systemGray, numberOfLines: 0, font: UIFont.systemFont(ofSize: 14, weight: .regular))
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = setupLabel(textColor: .black, numberOfLines: 0, font: UIFont.systemFont(ofSize: 16, weight: .regular))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var viewLabel: UILabel = {
        let label = setupLabel(textColor: .black, numberOfLines: 0, font: UIFont.systemFont(ofSize: 16, weight: .regular))
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Override Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutSetup()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setupCell(_ model: ModelPost) {
        modelPost = model
        titleLabel.text = model.author
        photoView.image = UIImage(named: model.image)
        descriptionView.text = model.description
        likesLabel.text = "Likes: \(model.likes)"
        viewLabel.text = "Views: \(model.views)"
    }
    
    // MARK: - Private Methods
    
    private func setupGestures() {
        let tapLikeLabelGesture = UITapGestureRecognizer(target: self, action: #selector(likeAction))
        likesLabel.addGestureRecognizer(tapLikeLabelGesture)
        
        let tapPostImageViewGesture = UITapGestureRecognizer(target: self, action: #selector(postImageViewAction))
        photoView.addGestureRecognizer(tapPostImageViewGesture)
    }
    
    @objc private func postImageViewAction() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            
            self.modelPost.views += 1
            self.viewLabel.text = "Views \(self.modelPost.views)"
            self.tapPostImageDelegate?.postImagePress(author: self.modelPost.author, description: self.modelPost.description, image: self.modelPost.image)
        }
    }
    
    @objc private func likeAction() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            
            self.modelPost.likes += 1
            self.likesLabel.text = "Likes \(self.modelPost.likes)"
        }
    }
    
    private func layoutSetup() {
        [whiteView, titleLabel, photoView, descriptionView, likesLabel, viewLabel] .forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            whiteView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            whiteView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),
            
            photoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            photoView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor),
            
            descriptionView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 16),
            descriptionView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            descriptionView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            likesLabel.trailingAnchor.constraint(equalTo: whiteView.centerXAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -16),
            
            viewLabel.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 16),
            viewLabel.leadingAnchor.constraint(equalTo: whiteView.centerXAnchor),
            viewLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),
            viewLabel.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - Extentions PostTableViewCell

extension PostTableViewCell {
    private func setupLabel(textColor: UIColor, numberOfLines: Int, font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        label.font = font
        return label
    }
}

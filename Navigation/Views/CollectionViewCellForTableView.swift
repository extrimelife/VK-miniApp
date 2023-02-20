//
//  PhotosCollectionViewCellForTableView.swift
//  Navigation
//
//  Created by roman Khilchenko on 07.05.2022.
//

import UIKit

final class CollectionViewCellForTableView: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let imagePhoto: UIImageView = {
        let imagePhoto = UIImageView()
        imagePhoto.translatesAutoresizingMaskIntoConstraints = false
        imagePhoto.contentMode = .scaleAspectFill
        imagePhoto.layer.cornerRadius = 10
        imagePhoto.clipsToBounds = true
        return imagePhoto
    }()
    
    // MARK: - Override Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    // Функция отвечает за показ фото
    func setupImageModel(_ image: ImageModel) {
        imagePhoto.image = UIImage(named: image.image)
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        contentView.addSubview(imagePhoto)
        
        NSLayoutConstraint.activate([
            imagePhoto.topAnchor.constraint(equalTo: contentView.topAnchor),
            imagePhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imagePhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

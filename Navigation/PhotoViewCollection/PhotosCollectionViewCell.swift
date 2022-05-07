//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by roman Khilchenko on 07.05.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private let imageForGallery: UIImageView = {
        let galleryImage = UIImageView()
        galleryImage .translatesAutoresizingMaskIntoConstraints = false
        galleryImage .contentMode = .scaleAspectFill
        galleryImage .clipsToBounds = true
        return galleryImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Функция отвечает за показ фото
    func setupImageModel(_ image: ImageModel) {
        imageForGallery.image = UIImage(named: image.image)
    }
    
    private func imageLayout() {
        contentView.addSubview(imageForGallery)
        
        // Констрейнт для imageView на TableView для CollectionView
        NSLayoutConstraint.activate([
            imageForGallery.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageForGallery.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageForGallery.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageForGallery.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    
}



//
//  PhotosCollectionViewCellForTableView.swift
//  Navigation
//
//  Created by roman Khilchenko on 07.05.2022.
//

import UIKit

class CollectionViewCellForTableView: UICollectionViewCell {
    
    private let imagePhoto: UIImageView = {
        let imagePhoto = UIImageView()
        imagePhoto.translatesAutoresizingMaskIntoConstraints = false
        imagePhoto.contentMode = .scaleAspectFill
        imagePhoto.layer.cornerRadius = 10
        imagePhoto.clipsToBounds = true 
        return imagePhoto
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
        imagePhoto.image = UIImage(named: image.image)
    }
    
    private func imageLayout() {
        contentView.addSubview(imagePhoto)
        
        // Констрейнт для imageView на TableView для CollectionView
        NSLayoutConstraint.activate([
            imagePhoto.topAnchor.constraint(equalTo: contentView.topAnchor),
            imagePhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imagePhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    
}

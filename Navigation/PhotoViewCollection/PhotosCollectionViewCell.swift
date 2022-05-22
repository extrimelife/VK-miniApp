//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by roman Khilchenko on 07.05.2022.
//

import UIKit

protocol PhotoCellDelegate: AnyObject {
    func tapAction(photo: UIImage)
    func cancelAnimationButton()
}

class PhotosCollectionViewCell: UICollectionViewCell {
    
    weak var buttonAllPhotoCellDelegate: PhotoCellDelegate?
    
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
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoAction))
        imageForGallery.isUserInteractionEnabled = true 
        imageForGallery.addGestureRecognizer(tapGesture)
    }

    @objc private func photoAction() {
        buttonAllPhotoCellDelegate?.tapAction(photo: imageForGallery.image!)
    }
    
    // Функция отвечает за показ фото
    func setupImageModel(_ image: ImageModel) {
        imageForGallery.image = UIImage(named: image.image)
    }
    
    private func imageLayout() {
        contentView.addSubview(imageForGallery)
        
        // Констрейнт для imageView на для CollectionView
        NSLayoutConstraint.activate([
            imageForGallery.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageForGallery.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageForGallery.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageForGallery.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    
}



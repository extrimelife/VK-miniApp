//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by roman Khilchenko on 07.05.2022.
//

import UIKit

// MARK: - Protocol PhotoCellDelegate

protocol PhotoCellDelegate: AnyObject {
    func tapAction(photo: UIImage)
    func cancelAnimationButton()
}

final class GalleryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    weak var buttonAllPhotoCellDelegate: PhotoCellDelegate?
    
    // MARK: - Private Properties
    
    private let imageForGallery: UIImageView = {
        let galleryImage = UIImageView()
        galleryImage .translatesAutoresizingMaskIntoConstraints = false
        galleryImage .contentMode = .scaleAspectFill
        galleryImage .clipsToBounds = true
        return galleryImage
    }()
    
    // MARK: - Override Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    // Функция отвечает за показ фото
    func setupImageModel(_ image: ImageModel) {
        imageForGallery.image = UIImage(named: image.image)
    }
    
    // MARK: - Private Methods
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoAction))
        imageForGallery.isUserInteractionEnabled = true
        imageForGallery.addGestureRecognizer(tapGesture)
    }
    
    @objc private func photoAction() {
        buttonAllPhotoCellDelegate?.tapAction(photo: imageForGallery.image!)
    }
    
    private func setupLayout() {
        contentView.addSubview(imageForGallery)
        NSLayoutConstraint.activate([
            imageForGallery.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageForGallery.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageForGallery.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageForGallery.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}



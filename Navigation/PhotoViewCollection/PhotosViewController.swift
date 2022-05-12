//
//  PhotosViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 07.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    var imageModel = ImageModel.makeImage()
    
    private lazy var galleryCollection: UICollectionView = {
        let layoutForCollection = UICollectionViewFlowLayout()
        let collectionGallery = UICollectionView(frame: .zero, collectionViewLayout: layoutForCollection )
        collectionGallery.translatesAutoresizingMaskIntoConstraints = false
        collectionGallery.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionGallery.dataSource = self
        collectionGallery.delegate = self
        return collectionGallery
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // устанавливаю title в галерее с фото
        self.navigationItem.title = "Photo Gallery"
        setup()
    }
    
    
    private func setup() {
        view.addSubview(galleryCollection)
        
        // Констрейнты для collectionView в галереи с фотографиями
        NSLayoutConstraint.activate([
            galleryCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            galleryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            galleryCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            galleryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupImageModel(imageModel[indexPath.item])
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    // Метод для определения высоты меджу фотографиями
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
    
    // Метод для определения расстояний со всех сторон
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
    
}


//
//  PhotosViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 07.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    var imageModel = ImageModel.makeImage()
    
    // Создаю черную вью для заднего фона при открытии фото на весь экран
    private let blackView: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        view.backgroundColor = .black
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.opacity = 0
        return view
    }()
    
    // Создаю кнопку крестик для выхода из полноэкранного режима
    private lazy var buttonCancelAnimation: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(cancelAnimationButton), for: .touchUpInside)
        button.tintColor = .systemGray4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    // Создаю UIImage для полноразмернного открытия фотографий
    private let fullImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "original1"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.opacity = 0
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
        self.navigationItem.title = "Галерея"
        setup()
    }
    
    
    private func setup() {
        [galleryCollection, blackView, fullImageView, buttonCancelAnimation].forEach({ view.addSubview($0) })
        
        
        NSLayoutConstraint.activate([
            
            // Констрейнты для collectionView в галереи с фотографиями
            galleryCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            galleryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            galleryCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            galleryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Констрейнты для полноразмерных фотографий из галереи
            fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fullImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            fullImageView.heightAnchor.constraint(equalTo: fullImageView.widthAnchor, multiplier: 1),
            
            // Констрейнты для кнопки крестика
            buttonCancelAnimation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            buttonCancelAnimation.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            buttonCancelAnimation.widthAnchor.constraint(equalToConstant: 40),
            buttonCancelAnimation.heightAnchor.constraint(equalTo: buttonCancelAnimation.widthAnchor, multiplier: 1)
            
            
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupImageModel(imageModel[indexPath.item])
        cell.buttonAllPhotoCellDelegate = self
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

// Реализовываю протокол PhotoCellDelegate
extension PhotosViewController: PhotoCellDelegate {
    func tapAction(photo: UIImage) {
        self.fullImageView.image = photo
        self.fullImageView.isUserInteractionEnabled = true
        self.navigationController?.isNavigationBarHidden = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            
            self.blackView.layer.opacity = 0.8
            self.fullImageView.layer.opacity = 1
            self.view.layoutIfNeeded()
            
        } completion: { _ in
            UIView.animate(withDuration: 0.3,
                           delay: 0.0) {
                self.buttonCancelAnimation.layer.opacity = 1
            }
        }
    }
    
    @objc func cancelAnimationButton() {
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            self.buttonCancelAnimation.layer.opacity = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0.0) {
                self.blackView.layer.opacity = 0.0
                self.fullImageView.layer.opacity = 0
                self.navigationController?.isNavigationBarHidden = false
                self.view.layoutIfNeeded()
            }
        }
    }
}

//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by roman Khilchenko on 06.05.2022.
//

import UIKit

// MARK: - Protocol PhotosTableViewCellDelegate

protocol PhotosTableViewCellDelegate: AnyObject {
    func buttonTap()
}

final class PhotosTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    weak var delegate: PhotosTableViewCellDelegate?
    
    // MARK: - Private Properties
    
    private let imageModel = ImageModel.makeImage()
    
    // Создаю TableViewCollection для фото на странице TableView в профиле
    private lazy var collectionView: UICollectionView = {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        let viewCollection = UICollectionView(frame: .zero ,collectionViewLayout: layoutCollection)
        viewCollection.translatesAutoresizingMaskIntoConstraints = false
        viewCollection.dataSource = self
        viewCollection.delegate = self
        viewCollection.register(CollectionViewCellForTableView.self, forCellWithReuseIdentifier: CollectionViewCellForTableView.identifier)
        return viewCollection
    }()
    
    // Создаю лейбл для надписи Photos
    private let labelText: UILabel = {
        let labelText = UILabel()
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.textColor = .black
        labelText.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return labelText
    }()
    
    // Создаю кнопку стрелочку выше CollectionView для перехода в галерею
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.addTarget(self, action: #selector(goToGallery), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Override Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setupLabel() {
        labelText.text = "Photos"
    }
    
    // MARK: - Private Methods
    
    @objc private func goToGallery() {
        delegate?.buttonTap()
    }
    
    private func setupLayout() {
        [collectionView, labelText, button] .forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12 - 8),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12 + 8),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            labelText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            labelText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            button.centerYAnchor.constraint(equalTo: labelText.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
}

// MARK: UICollectionViewDataSource
extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellForTableView.identifier, for: indexPath) as? CollectionViewCellForTableView else { return CollectionViewCellForTableView() }
        let imageModel = imageModel[indexPath.item]
        cell.setupImageModel(imageModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.width - sideInset * 3) / 4
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
}

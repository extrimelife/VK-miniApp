//
//  ProfileViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
// MARK: - Private Properties
    
    private let imageModel = ImageModel.makeImage()
    private var postModel = ModelPost.makePost()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .zero
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return tableView
    }()
    
 // MARK: - Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        hideKeyboardTappedAround()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Главная"
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: UITableViewDataSourse

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? postModel.count : imageModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell else { return PhotosTableViewCell() }
            cell.setupLabel()
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        default :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return PostTableViewCell() }
            let postModel = postModel[indexPath.row]
            cell.setupCell(postModel)
            cell.tapPostImageDelegate = self
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete  {
            if indexPath.row != 0 {
                tableView.beginUpdates()
                postModel.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
        }
    }
}

// MARK: UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let profileHeaderView = ProfileHeaderView()
        return profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         UITableView.automaticDimension
    }
}

// MARK: - PhotosTableViewCellDelegate

extension ProfileViewController: PhotosTableViewCellDelegate {
    func buttonTap() {
        let photosViewController = GalleryViewController()
        navigationController?.pushViewController(photosViewController, animated: true)
    }
    
}

// MARK: - UITextFieldDelegate

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func hideKeyboardTappedAround() {
        let press: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        press.cancelsTouchesInView = false
        view.addGestureRecognizer(press)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - TapPostImageDelegate

// Расширение для открытия поста в новой View со счетчиком просмотров
extension ProfileViewController: TapPostImageDelegate {
    func postImagePress(author: String, description: String, image: String) {
        let showVc = ShowPostViewController()
        showVc.titleLabel.text = author
        showVc.photoView.image = UIImage(named: image)
        showVc.descriptionView.text = description
        navigationController?.pushViewController(showVc, animated: true)
    }
}

//
//  ProfileViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Устанавливаю title в профиле
        navigationItem.title = "Профиль"
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .systemGray6
        setupLayout()
        hideKeyboardTappedAround()
        
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
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell else { return PhotosTableViewCell() }
            cell.setupLabel()
            //Вызов кнопки с переходом в галерею
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return PostTableViewCell() }
        let postModel = postModel[indexPath.row]
        cell.setupCell(postModel)
        cell.tapPostImageDelegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    // удаление по свайпу
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete  {
            if indexPath.row != 0 {
                tableView.beginUpdates()
                postModel.remove(at: indexPath.row - 1)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                
            }
        }
    }
    
}


// MARK: UiTAbleViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.backgroundColor = .systemGray6
        return section == 0 ? profileHeaderView : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
}

extension ProfileViewController: PhotosTableViewCellDelegate {
    func buttonTap() {
        let photosViewController = GalleryViewController()
        navigationController?.pushViewController(photosViewController, animated: true)
    }
    
}

//Расширение для закрытия клавиатуры при нажатии на любую часть экрана в профиле
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

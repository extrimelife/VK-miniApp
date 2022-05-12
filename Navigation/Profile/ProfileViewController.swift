//
//  ProfileViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let imageModel = ImageModel.makeImage()
    private let postModel = ModelPost.makePost()
    
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
        self.view.backgroundColor = .systemGray6
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
        return postModel.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
            cell.setupCell(postModel[indexPath.row - 1])
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
        cell.setupLabel("Photos")
        //Вызов кнопки с переходом в галерею
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
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
        return section == 0 ? 200 : 0
        
    }
}

extension ProfileViewController: PhotosTableViewCellDelegate {
    func buttonTap() {
        let photosViewController = PhotosViewController()
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

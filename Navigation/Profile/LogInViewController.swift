//
//  LogInViewController.swift
//  Navigation
//
//  Created by roman Khilchenko on 02.05.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let notificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupLayout()
        logTextField.delegate = self
        pasTextField.delegate = self
    
    }
    
    private let imageView: UIImageView = {
        let viewImage = UIImageView()
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        viewImage.image = .init(named: "logo")
        return viewImage
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .systemGray6
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.masksToBounds = true
        return stackView
    }()
    
    private let logTextField: UITextField = {
        let textFieldLog = UITextField()
        textFieldLog.translatesAutoresizingMaskIntoConstraints = false
        textFieldLog.layer.borderColor = UIColor.lightGray.cgColor
        textFieldLog.layer.borderWidth = 0.5
        textFieldLog.placeholder = "Email of phone"
        textFieldLog.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textFieldLog.frame.height))
        textFieldLog.leftViewMode = .always
        textFieldLog.textColor = .black
        textFieldLog.font = .systemFont(ofSize: 16)
        textFieldLog.tintColor = .lightGray
        return textFieldLog
    }()
    
    
    private let pasTextField: UITextField = {
        let textFieldPas = UITextField()
        textFieldPas.translatesAutoresizingMaskIntoConstraints = false
        textFieldPas.layer.borderColor = UIColor.lightGray.cgColor
        textFieldPas.layer.borderWidth = 0.5
        textFieldPas.placeholder = "Password"
        textFieldPas.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textFieldPas.frame.height))
        textFieldPas.leftViewMode = .always
        textFieldPas.textColor = .black
        textFieldPas.font = .systemFont(ofSize: 16)
        textFieldPas.tintColor = .lightGray
        textFieldPas.autocapitalizationType = .none
        textFieldPas.isSecureTextEntry = true
        return textFieldPas
    }()
    
    private let buttonView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "#4885CC")
        button.layer.cornerRadius = 10
        button.setTitle("Log In", for: .normal)
        button.tintColor = .white
        button.backgroundImage(for: .application)
        button.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        return button
    }()
    
    @objc private func goToProfile () {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //Дополнительная view для scroll view(без него scroll работать не будет)
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        contentView.addSubview(buttonView)
        [logTextField, pasTextField] .forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            
            // Констрейнт для картинки:
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            // Констрейнт для стэка:
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 120),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            // Констрейнт для кнопки:
            buttonView.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            buttonView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Констрейнт для scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Констрейнт для contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
        ])
        
    }
    
}

//Расширение для закрытия клавиатуры
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}



